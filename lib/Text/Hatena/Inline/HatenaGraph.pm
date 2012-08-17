package Text::Hatena::Inline::HatenaGraph;
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
            \[
                (?:
                    graph:t:(?<tag>[^\]]+)
                    |
                    graph:id:(?<name>$UNAME_PATTERN):(?<graph>[^\]]+?)
                    (?:
                        :(?<type>image)
                        (?::(?<size>large))?
                    )?
                    (?::d(?<day>\d+))?
                )
            \]
            |
            \[?
                (?<![[:alnum:]])
                graph:id:(?<name>$UNAME_PATTERN)
            \]?
        )
    }ix => sub {
        my ($context, $attr) = @_;
        my ($syntax, $tag, $name, $graphname, $type, $size, $day)
            = map { $attr->{$_} // $+{$_} // '' } qw/syntax tag name graph type size day/;
        $syntax =~ s{^\[(.+)\]$}{$1};
        my $link_target = $context->link_target;
        if ($tag) {
            my $entag = uri_escape_utf8($tag);
            return qq|<a href="http://graph.hatena.ne.jp/t/$entag"$link_target>$syntax</a>|;
        }
        if ($graphname) {
            my $engraphname = uri_escape_utf8($graphname);
            my $graph_url = "http://graph.hatena.ne.jp/$name/$engraphname/";
            $graph_url .= "?day=$day" if $day;
            if ($type eq 'image') {
                my $image_url = "http://graph.hatena.ne.jp/$name/graph?graphname=$engraphname";
                $image_url .= "&day=$day" if $day;
                $image_url .= "&mode=detail" if $size;
                return qq|<a href="$graph_url" class="hatena-graph-image"$link_target><img src="$image_url" class="hatena-graph-image" alt="$graphname" title="$graphname" /></a>|;
            } else {
                return qq|<a href="$graph_url"$link_target>$syntax</a>|;
            };
        }
        return qq|<a href="http://graph.hatena.ne.jp/$name/"$link_target>$syntax</a>|;
    };
};

1;
