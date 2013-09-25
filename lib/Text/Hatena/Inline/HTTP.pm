package Text::Hatena::Inline::HTTP;
use utf8;
use strict;
use warnings;
use Carp;
use Encode;
use HTML::Entities;
use URI::Escape qw/uri_escape_utf8/;

use Text::Hatena::Constants qw($URI_PATTERN);
use Text::Hatena::Inline::DSL;
use Text::Hatena::Embed;

my $char_wp  = q{A-Za-z0-9\-\.~/_?&=%#+:;,\@'\$*!\(\)}; # with paren
my $char_wop = q{A-Za-z0-9\-\.~/_?&=%#+:;,\@'\$*!};     # w/o  paren
my $pat_option = qr{(?:title|bookmark|star|favicon|barcode|embed|detail|movie(?::(?:small|w\d+|h\d+))*)};
my $pat_option_in_bracket = qr{(?:title=[^\[\]\n]*|title|bookmark|star|favicon|barcode|embed(?:\#[^\[\]\n]*)?|detail|movie(?::(?:small|w\d+|h\d+))*)};

build_inlines {
    syntax qr{

        # (http) 前読み・後読み + URL内に () が無い
        (?<= \( )
        (?<uri>
            (?:https?|ftp)://[$char_wop]+?
        )
        (?<option>
            (:$pat_option)+
        )?
        (?= \) )

        |

        # http 通常
        (?<uri>
            (?:https?|ftp)://[$char_wp]+?
        )
        (?<option>
            (:$pat_option)+
        )?
        (?![$char_wp])

        |

        # [http]
        \[
        (?<uri>
            (?:https?|ftp)://[^\[\]\n]+?
        )
        (?<option>
            (:$pat_option_in_bracket)+
        )?
        \]

    }ix => sub {
        no strict 'refs';
        my ($context, $attr) = @_;
        my ($uri, $option, $title) = map {
            $attr->{$_} // $+{$_}
        } qw/uri option title/;
        my $link_target = $context->link_target;

        $option //= '';
        $option =~ s{^:}{};

        my @options;
        # :title=foo:bar みたいなのに対応するため、optionになり得ない文字列はいっこ前のにくっつける
        for my $part (split /:/, $option) {
            if (!@options || $part =~ m{^($pat_option_in_bracket)$}) {
                push @options, $part;
            } else {
                $options[-1] .= ":$part";
            }
        }

        my $ret = '';;
        if (@options) {
            for my $option (@options) {
                my $sub_option;
                $option =~ s{^(title)=(.*)$}{$1}i
                    and $title = $2;
                $option =~ s{^(movie):([\w:]+)}{$1}i
                    and $sub_option = $2;
                $option =~ s{\#.+}{};
                my $func = lc $option . '_handler';
                $ret .= eval { $func->($context, $uri, $link_target, $title, $sub_option) };
            }
        } else {
            $ret = sprintf(
                q{<a href="%s"%s>%s</a>},
                $uri,
                $link_target,
                $uri,
            );
        }
        $ret;
    };
};

sub bookmark_handler {
    my ($context, $uri, $link_target) = @_;
    $uri =~ s/#/%23/;
    sprintf(
        '<a href="http://b.hatena.ne.jp/entry/%s" class="http-bookmark"%s><img src="http://b.hatena.ne.jp/entry/image/%s" alt="" class="http-bookmark" /></a>',
        $uri,
        $link_target,
        $uri,
    );
}

sub star_handler {
    my ($context, $uri, $link_target) = @_;
    sprintf(
        '<img src="http://s.st-hatena.com/entry.count.image?uri=%s" alt="" class="http-star" />',
        uri_escape_utf8($uri),
    );
}

sub favicon_handler {
    my ($context, $uri, $link_target) = @_;
    sprintf(
        '<a href="%s"%s><img src="http://cdn-ak.favicon.st-hatena.com/?url=%s" alt="" class="http-favicon" /></a>',
        $uri,
        $link_target,
        uri_escape_utf8($uri),
    );
}

sub title_handler {
    my ($context, $uri, $link_target, $title) = @_;

    length($title) or $title = get_title($context, $uri);

    sprintf(
        '<a href="%s"%s>%s</a>',
        $uri,
        $link_target,
        encode_entities(decode_entities($title)),
    );
}

sub get_title {
    my ($context, $uri) = @_;
    my $key = 'http:title:' . uri_escape_utf8($uri);
    my $title = $context->cache->get($key);
    if (!defined $title && $context->network_enabled) {
        eval {
            my $res = $context->ua->get($uri);
            my $content = decode_utf8($res->decoded_content || $res->content);
            ($title) = ($content =~ m|<title[^>]*>([^<]*)</title>|i);
            $title =~ s{^\s+|\s+$}{}g;
            $title =~ s{\s+}{ }g;
            $context->cache->set($key, $title,  60 * 60 * 24 * 30);
        };
        if ($@) {
            carp $@;
        }
    }
    $title = '' unless defined $title;
    $title = Encode::decode('utf-8', $title) unless Encode::is_utf8($title);
    return $title;
}

sub barcode_handler {
    my ($context, $uri, $link_target) = @_;
    sprintf(
        '<a href="%s" class="http-barcode"%s><img src="http://chart.apis.google.com/chart?chs=150x150&cht=qr&chl=%s" title="%s"/></a>',
        $uri,
        $link_target,
        uri_escape_utf8($uri),
        $uri,
    );
}

sub movie_handler {
    my ($context, $uri, $link_target, $title, $sub_option) = @_;
    my ($w, $h);
    my @options = split /:/, $sub_option || '';
    if ($uri =~ m{^https?://(?:jp|www)[.]youtube[.]com/watch[?]v=([\w\-]+)}) {
        for my $option (@options) {
            if (lc $option eq 'small') {
                $w = 300;
                $h = 225;
            } elsif ($option =~ /^w(\d+)/) {
                $w = $1;
            } elsif ($option =~ /^h(\d+)/) {
                $h = $1;
            }
        }
        if ($w && $h) {
        } elsif ($w && !$h) {
            $h = int($w/4*3);
        } elsif (!$w && $h) {
            $w = int($h*4/3);
        } else {
            ($w, $h) = (420, 315);
        }
        my $code = $1;
        return sprintf(
            '<iframe width="%d" height="%d" src="http://www.youtube.com/embed/%s?wmode=transparent" frameborder="0" allowfullscreen></iframe>',
            $w,
            $h,
            $code,
        );
    } elsif ($uri =~ m{^http://(ugomemo[.]hatena[.]ne[.]jp|flipnote[.]hatena[.]com)/([0-9A-Fa-f]{16})[@]DSi/movie/([0-9A-Za-z_]{10,30})}) {
        my ($domain, $did, $file) = ($1, $2, $3);
        my $swf = {
            'ugomemo.hatena.ne.jp' => 'http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf',
            'flipnote.hatena.com' => 'http://flipnote.hatena.com/js/flipplayer_s.swf',
        }->{$domain};
        return sprintf(
            q{<object data="%s" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="%s"></param><param name="FlashVars" value="did=%s&file=%s"></param></object>},
            $swf,
            $swf,
            $did,
            $file,
        );
    } elsif ($uri =~ m{^http://www.nicovideo.jp/watch/(\w+)}) {
        my $vid = $1;
        return sprintf(
            q{<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/%s"></script>},
            $vid,
        );
    } else {
        return sprintf(
            '<a href="%s"%s>%s</a>',
            $uri,
            $link_target,
            $uri,
        );
    }
}

sub embed_handler {
    my ($context, $uri, $link_target) = @_;
    my $embed = Text::Hatena::Embed->new({
        cache => $context->cache,
        lang  => $context->lang,
    });
    $embed->render($uri) || sprintf(
        '<a href="%s"%s>%s</a>',
        $uri,
        $link_target,
        $uri,
    );
}

sub detail_handler {
    my ($context, $uri) = @_;
    my $title = get_title($context, $uri) || $uri;
    my $escaped_uri = uri_escape_utf8($uri);
    return sprintf(
        qq{<iframe marginwidth="0" marginheight="0" src="http://b.hatena.ne.jp/entry.parts?url=%s" scrolling="no" frameborder="0" height="230" width="500"><div class="hatena-bookmark-detail-info"><a href="%s">%s</a><a href="http://b.hatena.ne.jp/entry/%s">はてなブックマーク- %s</a></div></iframe>},
        $escaped_uri,
        $uri,
        $title,
        $escaped_uri,
        $title,
    );
}

1;
__END__
