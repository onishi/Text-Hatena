package Text::Hatena::Inline::Unlink;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [] ___ []
    syntax qr{\[\]([\s\S]*?)\[\]}i => sub {
        my ($context, $unlink) = @_;
        $unlink;
    };
};

1;
__END__
