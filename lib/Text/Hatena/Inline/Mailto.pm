package Text::Hatena::Inline::Mailto;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [mailto:___]
    syntax qr<\[?mailto:([^\s\@:?]+\@[^\s\@:?]+(\?[^\s]+)?)\]?>i => sub {
        my ($context, $uri) = @_;
        sprintf('<a href="mailto:%s">%s</a>', $uri, $uri);
    };
};

1;
__END__
