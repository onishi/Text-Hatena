package Text::Hatena::Inline::HatenaDiary;
use utf8;
use strict;
use warnings;

use Text::Hatena::Constants qw($BLOGNAME_PATTERN);
use Text::Hatena::Inline::DSL;

build_inlines {
    # [id:___], [id:___:___], [id:___:___:___], [id:___:___#___]
    # (and [d:id:___] variants)
    syntax qr{
        \[?
        (?<![[:alnum:]])
        (
            (?:d:)
            id:($BLOGNAME_PATTERN) # $2 blogname
        ) # $1 name
        (
            \:(\d{8}|\d{6}) # $4 date
        )? # $3 colon_date
        (?:
            (\#|\:) # $5 delim
            ([a-zA-Z0-9_]+) # $6 section
        )?
        \]?
    }ix => sub {
        my ($context, $name, $blogname, $colon_date, $date, $delim, $section) = @_;
        $colon_date ||= '';
        $date       ||= '';
        $delim      ||= '';
        $section    ||= '';
        my $urlbase = 'http://d.hatena.ne.jp/';
        if ($context->stash->{mobile}) {
            $date = $date ? "?date=$date" : '';
            $date .= "#$section" if $section;
            return qq|<a href="${urlbase}$blogname/mobile$date">${name}${colon_date}${delim}$section</a>|;
        }
        elsif ($delim && length $date == 8) {
            my $path_delim = $delim eq ':' ? '/' : '#';
            return qq|<a href="${urlbase}$blogname/${date}${path_delim}$section">${name}${colon_date}${delim}$section</a>|;
        }
        else {
            return qq|<a href="${urlbase}$blogname/$date">${name}$colon_date</a>${delim}$section|;
        }
    };
};

1;
