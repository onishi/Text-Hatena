package Test::WWW::Stub;
use strict;
use utf8;
use warnings;

use AnyEvent::HTTP ();
use Carp ();
use Guard;  # guard
use HTTP::Server::PSGI;
use LWP::Protocol::PSGI;
use Plack::Request;
use Test::TCP ();
use Test::More ();
use URI;

our $SERVER = 'HTTP::Server::PSGI';

# PSGI app の場合は第2引数に Plack::Request でラップされたのもついてきます
our $Handlers = { };

sub register {
    my ($class, $uri_or_re, $app_or_res) = @_;
    $app_or_res //= [200, [], []];
    my $old_handler = $Handlers->{$uri_or_re};

    $Handlers->{$uri_or_re} = {
        type => (ref $uri_or_re || 'Str'),
        (ref $app_or_res eq 'CODE'
            ? ( app => $app_or_res )
            : ( res => $app_or_res )),
    };
    defined wantarray && return guard {
        if ($old_handler) {
            $Handlers->{$uri_or_re} = $old_handler;
        } else {
            delete $Handlers->{$uri_or_re};
        }
    };
}

my $app = sub {
    my ($env) = @_;
    my $req = Plack::Request->new($env);

    # クエリは app で処理してほしい
    my $uri = $req->uri;
    $uri->query('');
    $uri =~ s/\?$//;

    for my $key (keys %$Handlers) {
        my $handler = $Handlers->{$key};
        my @match;
        if ($handler->{type} eq 'Regexp' ? (@match = ($uri =~ qr<$key>)) : $uri eq $key) {
            if (my $app = $handler->{app}) {
                $env->{'test.www.stub.handler'} = [ $key, $app ];
                my $res = $app->($env, $req, @match);
                return $res if $res;
            } elsif (my $res = $handler->{res}) {
                return $res;
            } else {
                Test::More::BAIL_OUT 'Handler MUST be a PSGI app or an ARRAY';
            }
        }
    }

    my $method = $req->method;
    Test::More::diag "Unexpected external access: $method $uri";
    return [ 499, [], [] ];
};

LWP::Protocol::PSGI->register($app);

my $server;

sub ae {
    Carp::croak 'guard is required' unless defined wantarray;
    $server = Test::TCP->new(
        code => sub {
            my ($port) = @_;
            my $server = $SERVER->new(port => $port);
            $server->run(sub {
                my ($env) = @_;
                my $url = URI->new(delete $env->{'HTTP_X_ORIGINAL_URL'});
                $env->{PATH_INFO} = $url->path;
                $env->{REQUEST_URI} = $url->path_query;
                $env->{QUERY_STRING} = $url->query;
                $env->{SERVER_NAME} = $url->host;
                $env->{SERVER_PORT} = $url->port;
                $env->{HTTP_HOST} = $url->host;
                $env->{'psgi.url_scheme'} = $url->scheme;
                return $app->($env);
            });
        },
    );
    return guard {
        $server = undef;
    };
}

my $ORIGINAL_AEH_request = \&AnyEvent::HTTP::http_request;
my $AEH_request = sub ($$@) {
    my $cb = pop;
    my ($method, $url, %args) = @_;
    unless ($server) {
        Test::More::diag <<'...';
Unexpected AnyEvent::HTTP::request.
    my $g = Test::WWW::Stub->register('...' => sub { ... });
    my $s = Test::WWW::Stub->ae;
    ... test code with AnyEvent::HTTP::request ...
...
        ($args{on_header} || sub {})->({ Status => 499 });
        $cb->(undef, { Status => 499 });
        return;
    }

    my $headers = delete $args{headers} || {};
    $headers->{'X_ORIGINAL_URL'} = $url;
    $args{headers} = $headers;

    my $port = $server->port;
    @_ = ($method, "http://localhost:$port/", %args, $cb);
    goto &$ORIGINAL_AEH_request;
};

{
    no warnings 'redefine';
    *AnyEvent::HTTP::http_request = $AEH_request;
}

sub unstub {
    Carp::croak 'guard is required' unless defined wantarray;
    LWP::Protocol::PSGI->unregister;
    {
        no warnings 'redefine';
        *AnyEvent::HTTP::http_request = $ORIGINAL_AEH_request;
    }
    return guard {
        LWP::Protocol::PSGI->register($app);
        {
            no warnings 'redefine';
            *AnyEvent::HTTP::http_request = $AEH_request;
        }
    }
}

1;
__END__
