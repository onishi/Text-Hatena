package Text::Hatena::Inline::HatenaAntenna;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

my $UNAME_PATTERN = qr{[a-zA-Z][A-Za-z0-9_\-]{2,31}};

build_inlines {
    # [a:id:___]
    syntax qr{\[?((?<![[:alnum:]])a:id:($UNAME_PATTERN))\]?}i => sub {
        my ($context, $name, $username) = @_;
        qq|<a href="http://a.hatena.ne.jp/$username/">$name</a>|;
    };
};

1;
__END__
