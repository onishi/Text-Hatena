package Text::Hatena::Inline::Footnote;
use utf8;
use strict;
use warnings;
use URI::Escape;
use Text::Hatena::Inline::DSL;

build_inlines {
    # ((( )))
    syntax qr{(\(\(\(.*?\)\)\))}i => sub {
        my ($context, $unlink) = @_;
        $unlink;
    };

    # )(( ))(
    syntax qr{\)(\(\(.*?\)\))\(}i => sub {
        my ($context, $unlink) = @_;
        $unlink;
    };

    # (( ))
    syntax qr{\(\((.+?)\)\)}i => sub {
        my ($context, $note) = @_;
        push @{ $context->stash->{footnotes} ||= [] }, {};

        my $number   = @{ $context->stash->{footnotes} };
        my $title    = $note;
        $title =~ s/<[^>]+>//g;

        my $footnote = $context->stash->{footnotes}->[-1];
        $footnote->{number} = $number;
        $footnote->{note}   = $note;
        $footnote->{title}  = $title;
        return sprintf('<a href="#f%d" name="fn%d" title="%s">*%d</a>',
            $number,
            $number,
            $title,
            $number
        );
    };
};

1;
__END__

