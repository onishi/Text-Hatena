package Text::Hatena::Inline::TeX;
use utf8;
use strict;
use warnings;
use URI::Escape;
use HTML::Entities;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [tex:___]
    # \] で ] を escape できる
    syntax qr{
            \[
            tex:
            (
                (?:
                    \\\]
                    |
                    \\
                    |
                    [^\\\]]
                )+
            )
            \]
        }xi => sub {
        my ($context, $tex) = @_;

        $tex =~ s/\\([\[\]])/$1/g;

        return sprintf('<img src="http://chart.apis.google.com/chart?cht=tx&chl=%s" alt="%s"/>',
            uri_escape($tex),
            encode_entities($tex)
        );
    };
};

1;
__END__
