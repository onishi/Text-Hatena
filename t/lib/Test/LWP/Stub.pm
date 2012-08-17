package Test::LWP::Stub;
use strict;
use warnings;
use LWP::Protocol;
use URI;
use HTTP::Response;
use HTTP::Message::PSGI;
use Router::Simple;
use Scalar::Util qw(weaken isweak);
use Guard;

our $VERSION = '0.01';

our $ORIGINAL_LWP_Protocol_create = \&LWP::Protocol::create;

sub new {
    my $class = shift;

    my $self = bless {
        router => Router::Simple->new,
        fallback => [ 599, [], [] ],
        @_,
    }, $class;

    $self->{guard} = $self->stub_guard;

    return $self;
}

sub protocol_create_stub {
    my $self = shift;
    weaken $self unless isweak $self;
    return sub { LWP::Protocol::Test::LWP::Stub->new($self, @_) };
}

sub protocol_create_orig {
    my $self = shift;
    return $ORIGINAL_LWP_Protocol_create;
}

sub stub_guard {
    my $self = shift;

    no warnings 'redefine';

    my $protocol_create_orig = $self->protocol_create_orig;
    *LWP::Protocol::create   = $self->protocol_create_stub;

    return guard {
        *LWP::Protocol::create = $protocol_create_orig;
    };
}

sub unstub_guard {
    my $self = shift;

    no warnings 'redefine';

    my $protocol_create_stub = $self->protocol_create_stub;
    *LWP::Protocol::create   = $self->protocol_create_orig;

    return guard {
        *LWP::Protocol::create = $protocol_create_stub;
    };
}

sub register {
    my $self = shift;

    while (my ($path, $res) = splice @_, 0, 2) {
        my $option = {};

        if ($path =~ /^([A-Z]+) (.+)/) {
            $option->{method} = $1;
            $path = $2;
        }

        my $uri = URI->new($path);
        if ($uri->authority) {
            $option->{host} = $uri->authority;
            $path = $uri->path;
        }

        $self->{router}->connect($path, { response => $res }, $option);
    }
}

package
    LWP::Protocol::Test::LWP::Stub;

use Scalar::Util qw(blessed);

sub new {
    my ($class, $stub, $scheme, $ua) = @_;

    return bless {
        stub => $stub,
        scheme => $scheme,
        ua => $ua,
    }, $class;
}

sub _to_http_res {
    my ($res, @args) = @_;

    while () {
        if (ref $res eq 'CODE') {
            $res = $res->(@args);
        } elsif (ref $res eq 'ARRAY') {
            return HTTP::Response->from_psgi($res);
        } elsif (blessed $res && $res->isa('HTTP::Response')) {
            return $res;
        } else {
            die;
        }
    }
}

sub request {
    my ($self, $request, $proxy, $arg, $size, $timeout) = @_;

    my $stub = $self->{stub};

    my $env = $request->to_psgi;
    $env->{HTTP_HOST} ||= $env->{SERVER_NAME};

    my $m = $stub->{router}->match($env);
    my $res = $m && $m->{response} || $stub->{fallback};

    return _to_http_res $res, $request, $self->{ua}, $stub;
}

1;

__END__

=head1 NAME

Test::LWP::Stub - Stub for LWP

=head1 SYNOPSIS

  use Test::LWP::Stub;

  my $ua = LWP::UserAgent->new;
  my $s = Test::LWP::Stub->new(
      fallback => [ 599, [], [] ],
  );
  $s->register(
      'http://www.example.com/' => [ 204, [], [] ],
      'POST /*'                 => sub { my $req = shift; [ 201, ... ] },
  );

  $ua->get ('http://www.example.com/');       # => 204
  $ua->post('http://www.example.com/create'); # => 201
  $ua->get ('http://localhost/');             # => 599

=head1 DESCRIPTION

Test::LWP::Stub supplies stub respnoses for LWP methods.

=head1 AUTHOR

motemen E<lt>motemen@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
