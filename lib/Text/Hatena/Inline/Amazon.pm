package Text::Hatena::Inline::Amazon;
use utf8;
use strict;
use warnings;
use URI::Escape;
use Text::Hatena::Inline::DSL;

build_inlines {
    # [amazon:___]
    syntax qr{\[amazon:(.+)\]}i=> sub {
        my ($context, $keyword) = @_;
        my $amazonid = $context->stash->{affiliateid}->{amazonid} || 'hatena-22';
        my $link_target = $context->link_target;
        my $escaped_keyword = uri_escape_utf8($keyword);
        return qq|<a href="http://www.amazon.co.jp/exec/obidos/external-search?mode=blended&tag=$amazonid&keyword=$escaped_keyword"$link_target>amazon:$keyword</a>|;
    };
};

1;
__END__

