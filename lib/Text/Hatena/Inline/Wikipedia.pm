package Text::Hatena::Inline::Wikipedia;
use utf8;
use strict;
use warnings;
use URI::Escape;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [wikipedia:___]
    syntax qr{\[(wikipedia:(?:([a-z\-]+):)?([^\]]+))\]}i => sub {
        my ($context, $text, $lang, $word) = @_;
        $lang ||= 'ja';
        my $link_target = $context->link_target;
        my $escape_word = uri_escape_utf8($word);
        return qq|<a href="http://$lang.wikipedia.org/wiki/$escape_word"$link_target>$text</a>|;
    };
};

1;
__END__
