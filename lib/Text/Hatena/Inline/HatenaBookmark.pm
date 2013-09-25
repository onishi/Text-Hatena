package Text::Hatena::Inline::HatenaBookmark;
use utf8;
use strict;
use warnings;
use HTML::Entities;
use URI::Escape;

use Text::Hatena::Constants qw($UNAME_PATTERN);
use Text::Hatena::Inline::DSL;

my $UNAME_PATTERN = qr{[a-zA-Z][A-Za-z0-9_\-]{2,31}};

build_inlines {
    # [b:keyword:___]
    syntax qr{\[(b:keyword:([^\]]+))\]}ix => sub {
        my ($context, $name, $keyword) = @_;
        $keyword = decode_entities($keyword);
        $keyword = uri_escape_utf8($keyword);
        $keyword =~ s{%2f}{/}ig;
        qq{<a href="http://b.hatena.ne.jp/keyword/$keyword">$name</a>};
    };

    # [b:id:___t:___]
    syntax qr{\[(b:id:($UNAME_PATTERN):t:([^\]]+))\]}ix => sub {
        my ($context, $name, $username, $tag) = @_;
        $tag = encode_entities($tag);
        qq{<a href="http://b.hatena.ne.jp/$username/$tag/">$name</a>};
    };

    # [b:t:___]
    syntax qr{\[(b:t:([^\]]+))\]}ix => sub {
        my ($context, $name, $tag) = @_;
        $tag = encode_entities($tag);
        qq{<a href="http://b.hatena.ne.jp/t/$tag">$name</a>};
    };

    # [b:id:___:favorite] (or :asin or :YYYYMMDD)
    syntax qr/\[?((?<![[:alnum:]])b:id:($UNAME_PATTERN)(?::(favorite|asin|\d+))?)\]?/ix => sub {
        my ($context, $name, $username, $type) = @_;
        $type ||= '';
        qq{<a href="http://b.hatena.ne.jp/$username/$type">$name</a>};
    };
};

1;
__END__
