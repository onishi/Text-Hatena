package Text::Hatena::Inline::HatenaFotolife;
use utf8;
use strict;
use warnings;

use Text::Hatena::Constants qw($UNAME_PATTERN);
use Text::Hatena::Inline::DSL;

my $SYNTAX_PATTERN = qr{
    f:id:(?<user>$UNAME_PATTERN)
    (?:
        :(?<fid>\d{14})
        (?<ext>[jpgf])?
        (?:
            :(?<type>image|plain|movie)
            (?<options>
                (?: [:,](?:w\d+|h\d+|right|left|small|medium) )+
            )?
        )?
    )?
}xi;

build_inlines {
    <hatena:f />;
    # [f:id:___]
    # [f:id:___:___]
    # [f:id:___:___:TYPE]      (TYPE = image | plain | movie)
    # [f:id:___:___:TYPE:OPT+] (OPT = w___ | h___ | right | left | small | medium)
    syntax qr{
        \[ $SYNTAX_PATTERN \] | $SYNTAX_PATTERN
    }ix => sub {
        my ($context, $attr) = @_;
        my ($user, $fid, $ext, $type, $options) = map { $attr->{$_} // $+{$_} } qw/user fid ext type options/;
        if ($fid && $fid =~ s/([a-z])$//) {
            $ext = $1;
        }
        $ext     ||= '';
        $type    ||= '';
        $options ||= '';

        my $link_target = $context->link_target;

        my $name = "f:id:$user";
        $name .= ":$fid" if $fid;
        $name .= $ext if $ext;
        $name .= ":$type" if $type;
        $name .= $options if $options;
        if ($ext =~ /^g$/i) {
            $ext = 'gif';
        } elsif ($ext =~ /^p$/i) {
            $ext = 'png';
        } else {
            $ext = 'jpg';
        }
        if (!$fid) {
            return qq|<a href="http://f.hatena.ne.jp/$user/"$link_target>$name</a>|;
        } elsif ($type =~ /image|plain/i) {
            my $firstchar = substr($user,0,1);
            my $date = substr($fid,0,8);
            if ($context->{mobile}) {
                # 081117 center やめる
                my $img = qq|<img src="http://cdn-ak.f.st-hatena.com/images/fotolife/$firstchar/$user/$date/${fid}.$ext">|;
                return $type =~ /image/i ? qq|<a href="http://f.hatena.ne.jp/mobile/$user/$fid"$link_target>$img</a>| : $img;
            } else {
                my $attr = '';
                my $class = '';
                my $src = "http://cdn-ak.f.st-hatena.com/images/fotolife/$firstchar/$user/$date/${fid}.$ext";
                for my $option (split /[:,]/, $options) {
                    $option or next;
                    if ($option eq 'small') {
                        $src = "http://cdn-ak.f.st-hatena.com/images/fotolife/$firstchar/$user/$date/${fid}_m.gif";
                    } elsif ($option eq 'medium') {
                        $src = "http://cdn-ak.f.st-hatena.com/images/fotolife/$firstchar/$user/$date/${fid}_120.jpg";
                    } elsif ($option eq 'right') {
                        $class .= " hatena-image-right";
                    } elsif ($option eq 'left') {
                        $class .= " hatena-image-left";
                    } elsif ($option =~ /^w(\d+)$/i) {
                        $attr .= qq{ width="$1"};
                    } elsif ($option =~ /^h(\d+)$/i) {
                        $attr .= qq{ height="$1"};
                    }
                }
                my $img = qq|<img src="$src" alt="$name" title="$name" class="hatena-fotolife$class"$attr>|;
                return $type =~ /image/i ? qq|<a href="http://f.hatena.ne.jp/$user/$fid" class="hatena-fotolife"$link_target>$img</a>| : $img;
            }
        } elsif ($type =~ /movie/i) {
            my $ret = <<EOD;
<object data="http://f.hatena.ne.jp/tools/flvplayer_s.swf" type="application/x-shockwave-flash" width="320" height="276">
<param name="movie" value="http://f.hatena.ne.jp/tools/flvplayer_s.swf"></param>
<param name="FlashVars" value="fotoid=$fid&user=$user"></param>
<param name="wmode" value="transparent"></param>
</object>
EOD
            $ret =~ s/\n//g; # Avoid <br> insertion
            return $ret;
        }
        return qq|<a href="http://f.hatena.ne.jp/$user/$fid"$link_target>$name</a>|;
    };
};

1;
