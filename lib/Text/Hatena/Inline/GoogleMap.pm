package Text::Hatena::Inline::GoogleMap;
use utf8;
use strict;
use warnings;
use URI::Escape;

use Text::Hatena::Inline::DSL;

build_inlines {
    # This syntax is deprecated and will be removed at some future time.
    # [map:t:___]
    syntax qr{\[(map:t:([^\]]+))\]}i => sub {
        my ($context, $name, $tag) = @_;
        my $escaped_tag = uri_escape_utf8($tag);
        return qq|<a href="http://map.hatena.ne.jp/t/$escaped_tag">$name</a>|;
    };

    # [map:x___y___:TYPE]      (TYPE = map | satellite | hybrid)
    # [map:x___y___:TYPE:SIZE] (SIZE = h___ | w___)
    syntax qr{
        \[?
        (
            map:
            x(\-?[\d\.]+) # $2 x
            y(\-?[\d\.]+) # $3 y
            :(map|satellite|hybrid) # $4 mode
            (?:
                :(w|h) # $5 w_or_h
                (\d+)  # $6 size
            )?
        ) # $1 name
        \]?
    }ix => sub {
        my ($context, $name, $x, $y, $type, $w_or_h, $size) = @_;
        my $link_target = $context->link_target;
        my ($width, $height) = (200, 150);
        if (defined $w_or_h && $w_or_h eq 'w') {
            $width  = $size;
            $height = int($width / 4 * 3);
        }
        elsif (defined $w_or_h && $w_or_h eq 'h') {
            $height = $size;
            $width  = int($height / 3 * 4);
        }
        if ($width > 600 || $width < 100) {
            ($width, $height) = (200, 150);
        }
        return qq|<iframe src="http://map.hatena.ne.jp/frame?x=$x&y=$y&type=$type&width=$width&height=$height" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="$height" scrolling="no" width="$width"><a href="http://map.hatena.ne.jp/?x=$x&y=$y&z=4"$link_target>$name</a></iframe>|;
    };

    # [map:___:___] (Haiku-compatible style)
    syntax qr{\[?(map:(\-?[\d\.]+):(\-?[\d\.]+))\]?}i => sub {
        my ($context, $name, $y, $x) = @_;
        my $link_target = $context->link_target;
        my ($width, $height) = (200, 150);
        return qq|<iframe src="http://map.hatena.ne.jp/frame?x=$x&y=$y&type=map&width=$width&height=$height" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="$height" scrolling="no" width="$width"><a href="http://map.hatena.ne.jp/?x=$x&y=$y&z=4"$link_target>$name</a></iframe>|;
    };

    # [map:x___y___]
    syntax qr{\[?(map:x(\-?[\d\.]+)y(\-?[\d\.]+))\]?}i => sub {
        my ($context, $name, $x, $y) = @_;
        my $link_target = $context->link_target;
        return qq|<a href="http://map.hatena.ne.jp/?x=$x&y=$y&z=4"$link_target>$name</a>|;
    };

    # [map:x:___,y:___]
    # [map:x:___,y:___,t:___]
    syntax qr{\[?map:((?:x:[\d\.]+,y:[\d\.]+(?:,t:\d+)?\|?)+)\]?}i => sub {
        my ($context, $point) = @_;
        return qq|<iframe src="/mapx?points=$point" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="300" width="100%" scrolling="no"></iframe>|;
    };

    # XXX this xyntax is not testd at all in 052_map.t
    # [map:___]
    syntax qr{\[(map:([^\]]+))\]}i => sub {
        my ($context, $name, $word) = @_;
        my $escaped_word = uri_escape_utf8($word);
        my $link_target = $context->link_target;
        return qq|<a href="http://maps.google.co.jp/maps?q=$escaped_word"$link_target>$name</a>|;
    };

};

1;
__END__
