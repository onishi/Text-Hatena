package Text::Hatena::Inline::Google;
use utf8;
use strict;
use warnings;
use URI::Escape;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [google:___], [google:news:___], [google:images:___]
    syntax qr{\[google:(?:(news|images?):)?(.+)\]}i => sub {
        my ($context, $type, $word) = @_;
        $type ||= '';
        my $link_target = $context->link_target;
        my $esc_word = uri_escape_utf8($word);
        if ($type =~ /^news$/i) {
            $esc_word = uri_escape_utf8($word);
            return qq|<a href="http://news.google.co.jp/news?q=$esc_word&ie=utf-8&oe=utf-8"$link_target>google:$type:$word</a>|;
        } elsif ($type =~ /^image/i) {
            return qq|<a href="http://images.google.com/images?q=$esc_word&ie=utf-8&oe=utf-8"$link_target>google:$type:$word</a>|;
        } else {
            return qq|<a href="http://www.google.com/search?q=$esc_word&ie=utf-8&oe=utf-8"$link_target>google:$word</a>|;
        }
    };
};

1;
__END__
