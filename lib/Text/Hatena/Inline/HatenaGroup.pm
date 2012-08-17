package Text::Hatena::Inline::HatenaGroup;
use utf8;
use strict;
use warnings;

use Text::Hatena::Constants qw($UNAME_PATTERN $GNAME_PATTERN);
use Text::Hatena::Inline::DSL;
use Text::Hatena::Util qw(enword);

my $SYNTAX_PATTERN = qr{
    (?<syntax>
        \[g:(?<gname>$GNAME_PATTERN):(?<type>keyword):(?<keyword>[^\]]+)\]
        |
        \[?
        (?<![[:alnum:]])
        (?:
            g:(?<gname>$GNAME_PATTERN):id:(?<name>$UNAME_PATTERN)
            :(?<type>archive)
            (?::(?<month>\d{6}))?
            |
            g:(?<gname>$GNAME_PATTERN):id:(?<name>$UNAME_PATTERN)
            (?::(?<date>\d{8}|\d{6}))?
            (?:(?<delimiter>\#|:)(?<section>[a-zA-Z0-9_]+))?
            |
            g:(?<gname>$GNAME_PATTERN):(?<type>about)
            |
            g:(?<gname>$GNAME_PATTERN)
        )
        \]?
    )
}xi;

build_inlines {
    <hatena:g />;
    syntax qr{
        $SYNTAX_PATTERN
    }ix => sub {
        my ($context, $attr) = @_;
        my ($syntax, $gname, $name, $date, $delimiter, $section, $type, $month, $keyword)
            = map { $attr->{$_} // $+{$_} } qw/syntax gname name date delimiter section type month keyword/;

        $syntax =~ s{^\[(.+)\]$}{$1};
        $type = $type ? lc($type) : '';

        my $link_target = $context->link_target;

        my $base = sprintf 'http://%s.g.hatena.ne.jp/', $gname;
        $base .= sprintf('%s/', $name) if $name;

        if ($type eq 'about') {
            # group about
            return qq|<a href="${base}about"$link_target>$syntax</a>|;
        } elsif ($type eq 'keyword') {
            # group keyword
            $keyword =~ s{
                (?<presentation>:presentation)
                (?<mouse>:mouse)?
                $
            }{}xi;
            my $enword = enword($keyword);
            my $url = "${base}keyword/$enword";
            $url .= "?mode=presentation" if $+{presentation};
            $url .= "&mouse=true" if $+{mouse};
            return qq|<a href="$url" class="okeyword"$link_target>$syntax</a>|;
        } elsif ($type eq 'archive') {
            # diary archive
            $month = $month ? "/$month" : '';
            return qq|<a href="${base}archive$month"$link_target>$syntax</a>|;
        } elsif ($name) {
            # diary
            $delimiter =~ s{:}{/} if $delimiter;
            my $url = $base;
            $url .= $date if $date;
            $url .= $delimiter . $section if $section;
            return qq|<a href="$url"$link_target>$syntax</a>|;
        } else {
            # group
            return qq|<a href="$base"$link_target>$syntax</a>|;
        }
    };
};

1;
