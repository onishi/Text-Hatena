package Text::Hatena::Inline::Tag;
use utf8;
use strict;
use warnings;
use Text::Hatena::Inline::DSL;

build_inlines {
    syntax qr{(<a[^>]+>[\s\S]*?</a>)}i => sub {
        my ($context, $anchor) = @_;
        $anchor;
    };

    syntax qr{(<[^>]+>)}i => sub {
        my ($context, $tag) = @_;
        $tag;
    };
};

1;
__END__

