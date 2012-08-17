package Text::Hatena::Inline::Embed;
use utf8;
use strict;
use warnings;

# twitter shortcode
# [tweet https://twitter.com/motemen/status/170055613668274177]

use Text::Hatena::Inline::DSL;
use Text::Hatena::Embed;

build_inlines {
    syntax qr{
        \[
        (?:embed|tweet|twitter)
        [:\s]
        (?<uri>
            (?:https?)://[^\]]+?
        )
        \]
    }ix => sub {
        my ($context, $attr) = @_;
        my ($uri) = map {
            $attr->{$_} // $+{$_}
        } qw/uri/;

        # [tweet http://... lang='ja'] 用
        my $lang;
        if ($uri =~ s{ lang='(\w+)'$}{}) {
            $lang = $1;
        }

        my $link_target = $context->link_target;

        my $embed = Text::Hatena::Embed->new({
            cache => $context->cache,
            lang  => $lang || $context->lang,
        });
        $embed->render($uri) || sprintf(
            '<a href="%s"%s>%s</a>',
            $uri,
            $link_target,
            $uri,
        );
    };
};

1;
__END__
