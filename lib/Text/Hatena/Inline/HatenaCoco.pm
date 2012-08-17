package Text::Hatena::Inline::HatenaCoco;
use utf8;
use strict;
use warnings;
use HTML::Entities;
use HTTP::Request;
use JSON::XS;
use LWP::UserAgent;

use Text::Hatena::Constants qw($UNAME_PATTERN);
use Text::Hatena::Inline::DSL;

my $UNAME_PATTERN = qr{[a-zA-Z][A-Za-z0-9_\-]{2,31}};

build_inlines {
    # [c:id:___:___], [c:id:___:___:map]
    syntax qr{
        \[?
        (?<![[:alnum:]])
        (
            c:id:($UNAME_PATTERN) # $2 username
        ) # $1 name
        :(\d+) # $3 checkin_id
        (?:
            :(map) # $3 type
        )?
        \]?
    }ix => sub {
        my ($context, $name, $username, $checkin_id, $type) = @_;

        my $checkin_url = "http://c.hatena.ne.jp/$username/h/$checkin_id";
        my $map_img = '';
        my $link_text = $name;

        if ($context->network_enabled) {
            $link_text = $context->cache->get($name . '.link_text');
            $map_img = $context->cache->get($name . '.map_img');
            defined $link_text && $map_img or eval {
                my $res = $context->ua->get($checkin_url . '.json');
                my $checkin = decode_json($res->content);
                my $link_text = encode_entities($checkin->{spot}->{spot_name}, '<>&');
                my $lat = $checkin->{spot}->{lat};
                my $lng = $checkin->{spot}->{lon};
                my $map_img_url = qq{http://maps.google.com/maps/api/staticmap?center=$lat,$lng&zoom=14&size=100x100&sensor=false&markers=|$lat,$lng|};
                $map_img = qq{<img src="$map_img_url"> };

                $context->cache->set($name . '.link_text', $link_text);
                $context->cache->set($name . '.map_img', $map_img);
            };
            if ($@) {
                carp $@;
            }
        }

        qq{$map_img<a href="$checkin_url">$link_text</a>}
    };
};

1;
