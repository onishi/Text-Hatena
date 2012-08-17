package Text::Hatena::Inline::HatenaHaiku;
use utf8;
use strict;
use warnings;
use HTML::Entities;
use URI::Escape;

use Text::Hatena::Constants qw($UNAME_PATTERN);
use Text::Hatena::Inline::DSL;

my $UNAME_PATTERN = qr{[a-zA-Z][A-Za-z0-9_\-]{2,31}};

build_inlines {
    # [h:keyword:___]
    syntax qr{\[(h:keyword:([^\]]+))\]}ix => sub {
        my ($context, $name, $keyword) = @_;
        $keyword = uri_escape_utf8($keyword);
        my $link_target = $context->link_target;
        qq{<a href="http://h.hatena.ne.jp/keyword/$keyword"$link_target>$name</a>};
    };

    # [h:id:___]
    syntax qr{\[?(?<![[:alnum:]])h:id:($UNAME_PATTERN)\]?}ix => sub {
        my ($context, $username) = @_;
        my $link_target = $context->link_target;
        qq{<a href="http://h.hatena.ne.jp/$username/"$link_target>h:id:$username</a>};
    }
};

1;
__END__
