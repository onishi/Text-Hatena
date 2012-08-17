package Text::Hatena::Inline::HatenaQuestion;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [question:___:TYPE] (TYPE = title | detail | image:small | imagesmall | image)
    # [question:___:q___:TYPE]
    syntax qr<\[question:(\d{9,10})(?::q(\d+))?:title=([^\]]+?)\]>ix => sub {
        my ($context, $qid, $eq, $title) = @_;
        my $mobile = $context->stash->{mobile} ? 'mobile/' : '';
        my $url = "http://q.hatena.ne.jp/$mobile$qid";
        $url .= sprintf('#eq%02d', $eq) if $eq;
        my $link_target = $context->link_target;
        qq{<a href="$url"$link_target>$title</a>};
    };

    syntax qr/\[?(?<![[:alnum:]])question:(\d{9,10})(?::q(\d+))?(?::(title|detail|image:?small|image))\]?/ix => sub {
        my ($context, $qid, $eq, $mode) = @_;
        # See Hatena::Diary::HTMLParserBody line 1123 and below.
        '# TODO';
    };

    # [question:___], [question:___:q___]
    syntax qr/\[?question:(\d{9,10})(?::q(\d+))?\]?/ix => sub {
        my ($context, $qid, $eq) = @_;
        my $mobile = $context->stash->{mobile} ? 'mobile/' : '';
        my $url = "http://q.hatena.ne.jp/$mobile$qid";
        my $text = "question:$qid";
        if ($eq) {
            $url .= sprintf('#eq%02d', $eq);
            $text .= ":q$eq";
        }
        my $link_target = $context->link_target;
        qq{<a href="$url"$link_target>$text</a>};
    };
};

1;
