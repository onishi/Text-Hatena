package Text::Hatena::Inline::Niconico;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

our $SUMMARY = "この動画を含む日記";
our $BASEURL = "http://d.hatena.ne.jp";

build_inlines {
    # [niconico:___]
    syntax qr{
        \[niconico:
            (\w+)                      # $1 $vid
            (?:
            (
                (?:
                [:,](?:w\d+|h\d+|small)
                )+
            )?                         # $2 $movie_options
            )?
        \]
    }xms => sub {
        my ($context, $vid, $movie_options) = @_;
        $movie_options ||= '';
        my $urlbase = $context->stash->{baseurl} || $BASEURL . '/';
        my $videourl = "$BASEURL/video/";
        my $size = '';
        my ($w, $h);
        for my $option (split /[:,]/, $movie_options) {
            $option or next;
            if ($option eq 'small') {
                $size = '?w=300&h=251';
            } elsif ($option =~ /^w(\d+)$/i) {
                $w = $1;
                $w = 1 if $w <= 0;
            } elsif ($option =~ /^h(\d+)$/i) {
                $h = $1;
                $h = 36 if $h <= 35;
            }
        }
        if (!$size && $w && !$h) {
            $h = int($w / 485 * 350) + 35;
        } elsif (!$size && !$w && $h) {
            $w = int(($h - 35) * 485 / 385);
        }
        if (!$size && $w && $h) {
            $size = "?w=$w&h=$h";
        }
        my $ret = <<"END";
<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/$vid$size" charset="utf-8"></script>
<a href="${videourl}niconico/$vid" alt="$SUMMARY"><img src="${urlbase}images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="$SUMMARY"></a>
END
        chomp $ret;
        $ret =~ s/\n//g;
        return $ret;
    };
};

1;
__END__
