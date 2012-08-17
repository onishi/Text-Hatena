package Text::Hatena::Inline::HatenaKeyword;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;
use Text::Hatena::Constants qw($UNAME_PATTERN);
use URI::Escape qw(uri_escape_utf8);

build_inlines {
    <hatena:graph />;
    syntax qr{
        (?<syntax>
            \[?
                (?<![[:alnum:]])
                k:id:(?<name>$UNAME_PATTERN)
            \]?
        )
    }ix => sub {
        my ($context, $attr) = @_;
        my ($syntax, $name) = map { $attr->{$_} // $+{$_} } qw/syntax name/;
        $syntax =~ s{^\[(.+)\]$}{$1};
        my $link_target = $context->link_target;
        return qq|<a href="http://k.hatena.ne.jp/$name/"$link_target>$syntax</a>|;
    };

    # [[___]]
    syntax qr{\[\[([^\]]+)\]\]}ix => sub {
       my ($context, $keyword) = @_;
       my $escaped_keyword = uri_escape_utf8($keyword);
       my $link_target = $context->link_target;
       qq{<a href="http://d.hatena.ne.jp/keyword/$escaped_keyword"$link_target>$keyword</a>};
    };

};

1;
