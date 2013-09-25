use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

plan tests => 1 * blocks();

run_html;

done_testing;


__END__


=== f:id:fid:image(flv)
--- input
f:id:hatenadiary:20041007101545f:image
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545f:image" title="f:id:hatenadiary:20041007101545f:image" class="hatena-fotolife" itemprop="image"></a></span></p>

=== f:id:fid:movie
--- input
f:id:hatenadiary:20041007101545f:movie
--- expected
<p><object data="http://f.hatena.ne.jp/tools/flvplayer_s.swf" type="application/x-shockwave-flash" width="320" height="276">
<param name="movie" value="http://f.hatena.ne.jp/tools/flvplayer_s.swf"></param>
<param name="FlashVars" value="fotoid=20041007101545&user=hatenadiary"></param>
<param name="wmode" value="transparent"></param>
</object>
</p>

=== f:id
--- input
f:id:hatenadiary
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/" target="_blank">f:id:hatenadiary</a></p>

=== f:id:fid:image
--- input
f:id:hatenadiary:20041007101545j:image
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image" title="f:id:hatenadiary:20041007101545j:image" class="hatena-fotolife" itemprop="image"></a></span></p>

=== f:id:fid:image:small
--- input
f:id:hatenadiary:20041007101545j:image:small
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545_m.gif" alt="f:id:hatenadiary:20041007101545j:image:small" title="f:id:hatenadiary:20041007101545j:image:small" class="hatena-fotolife" itemprop="image"></a></span></p>

=== f:id:fid:image:medium
--- input
f:id:hatenadiary:20041007101545j:image:medium
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545_120.jpg" alt="f:id:hatenadiary:20041007101545j:image:medium" title="f:id:hatenadiary:20041007101545j:image:medium" class="hatena-fotolife"></a></span></p>

=== f:id:fid:image:w
--- input
f:id:hatenadiary:20041007101545j:image:w50
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:w50" title="f:id:hatenadiary:20041007101545j:image:w50" class="hatena-fotolife" style="width:50px"></a></span></p>

=== f:id:fid:image:h
--- input
f:id:hatenadiary:20041007101545j:image:h50
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:h50" title="f:id:hatenadiary:20041007101545j:image:h50" class="hatena-fotolife" style="height:50px"></a></span></p>

=== f:id:fid:image:right
--- input
f:id:hatenadiary:20041007101545j:image:right
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:right" title="f:id:hatenadiary:20041007101545j:image:right" class="hatena-fotolife hatena-image-right"></a></span></p>

=== f:id:fid:image:left
--- input
f:id:hatenadiary:20041007101545j:image:left
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:left" title="f:id:hatenadiary:20041007101545j:image:left" class="hatena-fotolife hatena-image-left"></a></span></p>

=== f:id:fid:image:right,w50,h10
--- input
f:id:hatenadiary:20041007101545j:image:right,w50,h10
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:right,w50,h10" title="f:id:hatenadiary:20041007101545j:image:right,w50,h10" class="hatena-fotolife hatena-image-right" style="width:50px;height:10px"></a></span></p>

=== f:id include Japanese
--- input
f:id:sampleのフォトライフ
--- expected
<p><a href="http://f.hatena.ne.jp/sample/" target="_blank">f:id:sample</a>のフォトライフ</p>


=== square bracket
--- input
[f:id:hatenadiary:20041007101545j:image:right,w50,h10]
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:right,w50,h10" title="f:id:hatenadiary:20041007101545j:image:right,w50,h10" class="hatena-fotolife hatena-image-right" style="width:50px;height:10px"></a></span></p>

=== angle bracket
--- input
<f:id:hatenadiary:20041007101545j:image:right,w50,h10>
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank" itemprop="url"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:right,w50,h10" title="f:id:hatenadiary:20041007101545j:image:right,w50,h10" class="hatena-fotolife hatena-image-right" style="width:50px;height:10px"></a></span></p>

=== f:id:fid:plain
--- input
f:id:hatenadiary:20041007101545j:plain
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:plain" title="f:id:hatenadiary:20041007101545j:plain" class="hatena-fotolife"></span></p>

=== f:id:fid:plain:small
--- input
f:id:hatenadiary:20041007101545j:plain:small
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545_m.gif" alt="f:id:hatenadiary:20041007101545j:plain:small" title="f:id:hatenadiary:20041007101545j:plain:small" class="hatena-fotolife"></span></p>

=== f:id:fid:plain:medium
--- input
f:id:hatenadiary:20041007101545j:plain:medium
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545_120.jpg" alt="f:id:hatenadiary:20041007101545j:plain:medium" title="f:id:hatenadiary:20041007101545j:plain:medium" class="hatena-fotolife"></span></p>

=== f:id:fid:plain:w
--- input
f:id:hatenadiary:20041007101545j:plain:w50
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:plain:w50" title="f:id:hatenadiary:20041007101545j:plain:w50" class="hatena-fotolife" style="width:50px"></span></p>

=== f:id:fid:plain:h
--- input
f:id:hatenadiary:20041007101545j:plain:h50
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:plain:h50" title="f:id:hatenadiary:20041007101545j:plain:h50" class="hatena-fotolife" style="height:50px"></span></p>

=== f:id:fid:plain:right
--- input
f:id:hatenadiary:20041007101545j:plain:right
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:plain:right" title="f:id:hatenadiary:20041007101545j:plain:right" class="hatena-fotolife hatena-image-right"></span></p>

=== f:id:fid:plain:left
--- input
f:id:hatenadiary:20041007101545j:plain:left
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:plain:left" title="f:id:hatenadiary:20041007101545j:plain:left" class="hatena-fotolife hatena-image-left"></span></p>

=== f:id:fid:plain:right,w50,h10
--- input
f:id:hatenadiary:20041007101545j:plain:right,w50,h10
--- expected
<p><span itemscope itemtype="http://schema.org/Photograph"><img itemprop="image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:plain:right,w50,h10" title="f:id:hatenadiary:20041007101545j:plain:right,w50,h10" class="hatena-fotolife hatena-image-right" style="width:50px;height:10px"></span></p>
