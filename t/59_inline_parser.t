use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Test::Base;
use Text::Hatena::Inline::Test;
use Text::Hatena::Inline::Parser;
use HTML::Entities;

plan tests => 1 * blocks() + 2; # subtest

run_html;

subtest 'remove_comment' => sub {
    my $th = Text::Hatena->new(
        remove_comment => 0,
    );
    my $thi = Text::Hatena::Inline::Parser->new(
        context => $th,
        inlines => $th->{inlines},
    );
    my $got = $thi->format('foo<!-- bar -->baz');
    eq_or_diff $got, 'foo<!-- bar -->baz';
};

subtest 'fallback_handler' => sub {
    my $th = Text::Hatena->new(
        fallback_handler => sub {
            my ($self, $tagname, $attr, $attrseq, $text) = @_;
            $tagname =~ m{^hatena:(\w+)$} or return $text;
            my $module_name = $1;
            my $result = sprintf qq|<div data-hatena-module="%s" data-hatena-syntax="%s"|,
                $module_name, encode_entities($text, qq|<>&"'\r\n|);
            for my $k (sort keys %{$attr || {}}) {
                my $v = $attr->{$k};
                $result .= qq| $k="$v"|;
            }
            $result .= '></div>';
            return $result;
        }
    );
    my $thi = Text::Hatena::Inline::Parser->new(
        context => $th,
        inlines => $th->{inlines},
    );
    my $got = $thi->format('<hatena:rss href="http://d.hatena.ne.jp/hatenadiary/rss">');
    eq_or_diff $got, '<div data-hatena-module="rss" data-hatena-syntax="&lt;hatena:rss href=&quot;http://d.hatena.ne.jp/hatenadiary/rss&quot;&gt;" href="http://d.hatena.ne.jp/hatenadiary/rss"></div>';
};

done_testing;

__END__

=== <a href="">
--- input
<a href="http://example.com/">http://example.com/</a>
--- expected
<a href="http://example.com/">
http://example.com/
</a>

=== f:id
--- input
f:id:onishi:20101106112600j:image
--- expected
<span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <hatena f:id>
--- input
<hatena f:id:onishi:20101106112600j:image>
--- expected
<span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <hatena f:id>
--- input
<hatena f:id:onishi:20101106112600j:image class="hoge">
--- expected
<span class="hoge" itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <hatena f:id>
--- input
<hatena f:id:onishi:20101106112600j:image data-hoge="hoge">
--- expected
<span data-hoge="hoge" itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <hatena:f:id>
--- input
<hatena:f:id:onishi:20101106112600j:image>
--- expected
<span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <f:id>
--- input
<f:id:onishi:20101106112600j:image>
--- expected
<span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <hoge> invalid tag
--- input
<hoge></hoge>
--- expected
<hoge></hoge>

=== <hatena:f />
--- input
<hatena:f user="onishi" fid="20101106112600j" type="image">
--- expected
<span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== <hatena:f />
--- input
<hatena:f user="onishi" fid="20101106112600" ext="j" type="image">
--- expected
<span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span>

=== comment
--- input
foo<!-- bar -->baz
--- expected
foo<!-- -->baz

=== fallback
--- input
<hatena:hoge foo="bar">
--- expected
<hatena:hoge foo="bar">

=== span
--- input
<span>f:id:onishi:20101106112600j:image</span>
--- expected
<span><span itemscope="itemscope" itemtype="http://schema.org/Photograph"><a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank"><img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img></a></span></span>

=== script
--- input
<script>f:id:onishi:20101106112600j:image</script>
--- expected
<script>f:id:onishi:20101106112600j:image</script>

=== iframe
--- input
<iframe width="312" height="176" src="http://ext.nicovideo.jp/thumb/sm13771590" scrolling="no" style="border:solid 1px #CCC;" frameborder="0"><a href="http://www.nicovideo.jp/watch/sm13771590">【ニコニコ動画】【初音ミク】さよなら忠犬ジュピター【オリジナル】</a></iframe>
--- expected
<iframe width="312" height="176" src="http://ext.nicovideo.jp/thumb/sm13771590" scrolling="no" style="border:solid 1px #CCC;" frameborder="0"><a href="http://www.nicovideo.jp/watch/sm13771590">【ニコニコ動画】【初音ミク】さよなら忠犬ジュピター【オリジナル】</a></iframe>

=== data-unlink
--- input
<span data-unlink>f:id:onishi:20101106112600j:image</span>
--- expected
<span data-unlink>f:id:onishi:20101106112600j:image</span>

=== data-unlink
--- input
<span data-unlink>f:id:onishi:20101106112600j:image</span>f:id:onishi:20101106112600j:image
--- expected
<span data-unlink>f:id:onishi:20101106112600j:image</span>
<span itemscope itemtype="http://schema.org/Photograph">
<a class="hatena-fotolife" href="http://f.hatena.ne.jp/onishi/20101106112600" itemprop="url" target="_blank">
<img alt="f:id:onishi:20101106112600j:image" class="hatena-fotolife" itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/o/onishi/20101106/20101106112600.jpg" title="f:id:onishi:20101106112600j:image"></img>
</a>
</span>

=== unknown-tag
--- input
<unko>hoge</unko>
--- expected
<unko>hoge</unko>
