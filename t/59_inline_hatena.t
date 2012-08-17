use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

plan tests => 1 * blocks();

SKIP: {
    skip "not yet", 1 * blocks();
    run_html;
};


done_testing;


__END__



=== last
--- SKIP
--- LAST
--- input
--- expected

=== asin:image
--- input
asin:B0006H2U6Y:image
--- expected
<p><a href="http://d.hatena.ne.jp/asin/B0006H2U6Y" class="asin"><img src="http://ecx.images-amazon.com/images/I/51ZY4FCAA8L._SL160_.jpg" alt="Canon ¥Ç¥¸¥¿¥ë°ì´ã¥ì¥Õ¥«¥á¥é EOS-1Ds Mark II ¥Ü¥Ç¥£" title="Canon ¥Ç¥¸¥¿¥ë°ì´ã¥ì¥Õ¥«¥á¥é EOS-1Ds Mark II ¥Ü¥Ç¥£" class="asin"></a></p>

=== ASIN:image
--- input
ASIN:B0006H2U6Y:image
--- expected
<p><a href="http://d.hatena.ne.jp/asin/B0006H2U6Y" class="asin"><img src="http://ecx.images-amazon.com/images/I/51ZY4FCAA8L._SL160_.jpg" alt="Canon ¥Ç¥¸¥¿¥ë°ì´ã¥ì¥Õ¥«¥á¥é EOS-1Ds Mark II ¥Ü¥Ç¥£" title="Canon ¥Ç¥¸¥¿¥ë°ì´ã¥ì¥Õ¥«¥á¥é EOS-1Ds Mark II ¥Ü¥Ç¥£" class="asin"></a></p>

=== file:filename (simple)
--- skip
not alivable
--- input
[file:onishi:foobar.txt]
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/files/foobar.txt">foobar.txt</a> <a href="http://d.hatena.ne.jp/onishi/files/foobar.txt?d=download"><img src="http://www.hatena.ne.jp/images/common/icon-download.gif" alt="Ä¾"></a></p>

=== file:filename (multibyte)
--- skip
not alivable
--- input
[file:onishi:¤Æ¤¹¤È.txt]
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/files/%E3%81%A6%E3%81%99%E3%81%A8.txt">¤Æ¤¹¤È.txt</a> <a href="http://d.hatena.ne.jp/onishi/files/%E3%81%A6%E3%81%99%E3%81%A8.txt?d=download"><img src="http://www.hatena.ne.jp/images/common/icon-download.gif" alt="Ä¾"></a></p>

=== file:filename (.png, multibyte)
--- skip
not alivable
--- input
[file:onishi:¤Õ¤©¤ª¤ª¤ª.png:image]
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/files/%E3%81%B5%E3%81%89%E3%81%8A%E3%81%8A%E3%81%8A.png?d=.png" class="http-image" target="_blank"><img src="http://d.hatena.ne.jp/onishi/files/%E3%81%B5%E3%81%89%E3%81%8A%E3%81%8A%E3%81%8A.png?d=.png" class="http-image" alt="http://d.hatena.ne.jp/onishi/files/%E3%81%B5%E3%81%89%E3%81%8A%E3%81%8A%E3%81%8A.png?d=.png"></a></p>

=== file:filename (.png)
--- skip
not alivable
--- input
[file:onishi:foobar.png:image:h50]
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/files/foobar.png?d=.png" class="http-image" target="_blank"><img src="http://d.hatena.ne.jp/onishi/files/foobar.png?d=.png" class="http-image" alt="http://d.hatena.ne.jp/onishi/files/foobar.png?d=.png" height="50"></a></p>

=== file:filename (movie)
--- skip
not alivable
--- input
[file:onishi:unko.flv:movie]
--- expected
<p><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="320" height="265" id="flvplayer" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="http://g.hatena.ne.jp/tools/flvplayer_2.swf" />
<param name="quality" value="high" />
<param name="bgcolor" value="#ffffff" />
<param name="FlashVars" value="moviePath=http://d.hatena.ne.jp/onishi/files/unko.flv?d=.flv" />
<embed src="http://g.hatena.ne.jp/tools/flvplayer_2.swf" FlashVars="moviePath=http://d.hatena.ne.jp/onishi/files/unko.flv?d=.flv" quality="high" bgcolor="#ffffff" width="320" height="265" name="flvplayer" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
</p>

=== file:filename (evil)
--- skip
not alivable
--- input
[file:onishi:<script type="javascript">alert("")</script>]
--- expected
<p>[file:onishi:&lt;script type="javascript"&gt;alert("")&lt;/script&gt;]</p>

=== ugomemo
--- skip
not alivable
--- input
[http://ugomemo.hatena.ne.jp/0EB03A80BC7D7DBA@DSi/movie/7DD445_086B8A571518B_000:movie]
--- expected
<p><object data="http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf"></param><param name="FlashVars" value="did=0EB03A80BC7D7DBA&file=7DD445_086B8A571518B_000"></param></object></p>

=== flipnote
--- skip
not alivable
--- input
[http://flipnote.hatena.com/0EB03A80BC7D7DBA@DSi/movie/7DD445_086B8A571518B_000:movie]
--- expected
<p><object data="http://flipnote.hatena.com/js/flipplayer_s.swf" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="http://flipnote.hatena.com/js/flipplayer_s.swf"></param><param name="FlashVars" value="did=0EB03A80BC7D7DBA&file=7DD445_086B8A571518B_000"></param></object></p>

=== ugomemo
--- skip
not alivable
--- input
ugomemo:0E61C75C9B5AD90B:7DD313_086631E87C8F4_000
--- expected
<p><object data="http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf"></param><param name="FlashVars" value="did=0E61C75C9B5AD90B&file=7DD313_086631E87C8F4_000"></param></object></p>

=== flipnote
--- skip
not alivable
--- input
flipnote:1920BA80AA34FFA4:34FFA4_08E46070DB94E_000
--- expected
<p><object data="http://flipnote.hatena.com/js/flipplayer_s.swf" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="http://flipnote.hatena.com/js/flipplayer_s.swf"></param><param name="FlashVars" value="did=1920BA80AA34FFA4&amp;file=34FFA4_08E46070DB94E_000&amp;domain=flipnote"></param></object></p>

=== g:hhh:id:jkondo
--- skip
not alivable
--- input
g:hhh:id:jkondo
--- expected
<p><a href="http://hhh.g.hatena.ne.jp/jkondo/">g:hhh:id:jkondo</a></p>

=== g:kkk:id:jkondo
--- skip
not alivable
--- input
g:kkk:id:jkondo
--- expected
<p><a href="http://kkk.g.hatena.ne.jp/jkondo/">g:kkk:id:jkondo</a></p>

=== k:id:jkondo
--- skip
not alivable
--- input
k:id:jkondo
--- expected
<p><a href="http://k.hatena.ne.jp/jkondo/" target="_blank">k:id:jkondo</a></p>

=== f:id:fid:image(flv)
--- input
f:id:hatenadiary:20041007101545f:image
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545f:image" title="f:id:hatenadiary:20041007101545f:image" class="hatena-fotolife"></a></p>

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

=== http title + bookmark 1
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:title:bookmark]
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">¤Ï¤Æ¤Ê</a><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a></p>

=== http title + bookmark 2
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:title=hatena:bookmark]
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">hatena</a><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a></p>


=== http bookmark + title 1
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:bookmark:title]
--- expected
<p><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/" target="_blank">¤Ï¤Æ¤Ê</a></p>

=== http bookmark + title 2
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:bookmark:title=hatena]
--- expected
<p><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/" target="_blank">hatena</a></p>

=== http bookmark
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:bookmark]
--- expected
<p><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a></p>

=== http bookmark 2 (#)
--- skip
not alivable
--- input
[http://d.hatena.ne.jp/lionfan/20080723#1216833707:bookmark]
--- expected
<p><a href="http://b.hatena.ne.jp/entry/http://d.hatena.ne.jp/lionfan/20080723%231216833707" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://d.hatena.ne.jp/lionfan/20080723%231216833707" alt="" class="http-bookmark"></a></p>

=== http bookmark 3 (?)
--- skip
not alivable
--- input
[http://gigazine.net/index.php?/news/comments/20080723_psp_3000/:bookmark]
--- expected
<p><a href="http://b.hatena.ne.jp/entry/http://gigazine.net/index.php?/news/comments/20080723_psp_3000/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://gigazine.net/index.php?/news/comments/20080723_psp_3000/" alt="" class="http-bookmark"></a></p>

=== http image url
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image=http://www.hatena.ne.jp/images/top/h1.gif]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" alt="http://www.hatena.ne.jp/"></a></p>

=== http image url w
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image=http://www.hatena.ne.jp/images/top/h1.gif:w100]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" alt="http://www.hatena.ne.jp/" width="100"></a></p>

=== http image url h
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image=http://www.hatena.ne.jp/images/top/h1.gif:h100]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" alt="http://www.hatena.ne.jp/" height="100"></a></p>

=== http image url right
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image=http://www.hatena.ne.jp/images/top/h1.gif:right]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image hatena-image-right" alt="http://www.hatena.ne.jp/"></a></p>

=== http image url left
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image=http://www.hatena.ne.jp/images/top/h1.gif:left]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image hatena-image-left" alt="http://www.hatena.ne.jp/"></a></p>

=== http image url mix
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image=http://www.hatena.ne.jp/images/top/h1.gif:right,w50,h10]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image hatena-image-right" alt="http://www.hatena.ne.jp/" width="50" height="10"></a></p>

=== wikipedia (default)
--- skip
not alivable
--- input
[wikipedia:¤Ï¤Æ¤Ê]
--- expected
<p><a href="http://ja.wikipedia.org/wiki/%E3%81%AF%E3%81%A6%E3%81%AA" target="_blank">wikipedia:¤Ï¤Æ¤Ê</a></p>

=== wikipedia (case insensitive)
--- skip
not alivable
--- input
[Wikipedia:¤Ï¤Æ¤Ê]
--- expected
<p><a href="http://ja.wikipedia.org/wiki/%E3%81%AF%E3%81%A6%E3%81%AA" target="_blank">Wikipedia:¤Ï¤Æ¤Ê</a></p>

=== wikipedia (en)
--- skip
not alivable
--- input
[wikipedia:en:blog]
--- expected
<p><a href="http://en.wikipedia.org/wiki/blog" target="_blank">wikipedia:en:blog</a></p>

=== wikipedia (cbk-zam)
--- skip
not alivable
--- input
[wikipedia:cbk-zam:Madonna]
--- expected
<p><a href="http://cbk-zam.wikipedia.org/wiki/Madonna" target="_blank">wikipedia:cbk-zam:Madonna</a></p>

=== haiku id
--- skip
not alivable
--- input
h:id:onishi
--- expected
<p><a href="http://h.hatena.ne.jp/onishi/" target="_blank">h:id:onishi</a></p>

=== haiku id(2)
--- skip
not alivable
--- input
[h:id:onishi]
--- expected
<p><a href="http://h.hatena.ne.jp/onishi/" target="_blank">h:id:onishi</a></p>

=== haiku keyword
--- skip
not alivable
--- input
[h:keyword:¤Ï¤Æ¤Ê¥Ï¥¤¥¯]
--- expected
<p><a href="http://h.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA%E3%83%8F%E3%82%A4%E3%82%AF" target="_blank">h:keyword:¤Ï¤Æ¤Ê¥Ï¥¤¥¯</a></p>

=== ASIN/ISBN :title
--- input
ISBN:9784172600817:title
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816">ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)</a></p>

=== ASIN/ISBN
--- input
[ISBN:9784172600817:title]
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816">ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)</a></p>

=== ASIN/ISBN :image
--- input
ISBN:9784172600817:image
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL160_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" class="asin"></a></p>

=== ASIN/ISBN [ :image]
--- input
[ISBN:9784172600817:image]
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL160_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" class="asin"></a></p>

=== ASIN/ISBN :detail
--- input
ISBN:9784172600817:detail
--- expected
<div class="hatena-asin-detail">
<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4172600816/hatena-hamazou-22/"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL160_.jpg" class="hatena-asin-detail-image" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)"></a>
<div class="hatena-asin-detail-info">
<p class="hatena-asin-detail-title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4172600816/hatena-hamazou-22/">ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)</a></p>
<ul>
<li><span class="hatena-asin-detail-label">ºî¼Ô:</span> <a href="http://d.hatena.ne.jp/keyword/%C1%ED%CC%B3%BE%CA" class="keyword">ÁíÌ³¾Ê</a></li>
<li><span class="hatena-asin-detail-label">½ÐÈÇ¼Ò/¥á¡¼¥«¡¼:</span> <a href="http://d.hatena.ne.jp/keyword/%B9%F1%CE%A9%B0%F5%BA%FE%B6%C9" class="keyword">¹ñÎ©°õºþ¶É</a></li>
<li><span class="hatena-asin-detail-label">È¯ÇäÆü:</span> 2006/04</li>
<li><span class="hatena-asin-detail-label">¥á¥Ç¥£¥¢:</span> Ã±¹ÔËÜ</li>
<li><a href="http://d.hatena.ne.jp/asin/4172600816" target="_blank">¤³¤Î¾¦ÉÊ¤ò´Þ¤à¥Ö¥í¥° (2·ï) ¤ò¸«¤ë</a></li>
</ul>
</div>
<div class="hatena-asin-detail-foot"></div>
</div>

=== ASIN/ISBN [ :detail]
--- input
[ISBN:9784172600817:detail]
--- expected
<div class="hatena-asin-detail">
<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4172600816/hatena-hamazou-22/"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL160_.jpg" class="hatena-asin-detail-image" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)"></a>
<div class="hatena-asin-detail-info">
<p class="hatena-asin-detail-title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4172600816/hatena-hamazou-22/">ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)</a></p>
<ul>
<li><span class="hatena-asin-detail-label">ºî¼Ô:</span> <a href="http://d.hatena.ne.jp/keyword/%C1%ED%CC%B3%BE%CA" class="keyword">ÁíÌ³¾Ê</a></li>
<li><span class="hatena-asin-detail-label">½ÐÈÇ¼Ò/¥á¡¼¥«¡¼:</span> <a href="http://d.hatena.ne.jp/keyword/%B9%F1%CE%A9%B0%F5%BA%FE%B6%C9" class="keyword">¹ñÎ©°õºþ¶É</a></li>
<li><span class="hatena-asin-detail-label">È¯ÇäÆü:</span> 2006/04</li>
<li><span class="hatena-asin-detail-label">¥á¥Ç¥£¥¢:</span> Ã±¹ÔËÜ</li>
<li><a href="http://d.hatena.ne.jp/asin/4172600816" target="_blank">¤³¤Î¾¦ÉÊ¤ò´Þ¤à¥Ö¥í¥° (2·ï) ¤ò¸«¤ë</a></li>
</ul>
</div>
<div class="hatena-asin-detail-foot"></div>
</div>

=== ASIN/ISBN :image:small
--- input
ISBN:9784172600817:image:small
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL75_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" class="asin"></a></p>

=== ASIN/ISBN [ :image:small]
--- input
[ISBN:9784172600817:image:small]
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL75_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" class="asin"></a></p>

=== ASIN/ISBN [ :image:left]
--- input
[ISBN:9784172600817:image:left]
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL160_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" class="asin hatena-image-left"></a></p>

=== ASIN/ISBN [ :image:small,w90]
--- input
[ISBN:9784172600817:image:small,w90]
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL75_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" width="90" class="asin"></a></p>

=== ASIN/ISBN [ :image:w90,h67,right]
--- input
[ISBN:9784172600817:image:w90,h67,right]
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4172600816" class="asin"><img src="http://ecx.images-amazon.com/images/I/513EV7GN34L._SL160_.jpg" alt="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" title="ÃÏÊýºâÀ¯Çò½ñ (Ê¿À®18Ç¯ÈÇ)" width="90" height="67" class="asin hatena-image-right"></a></p>

=== ASIN/ISBN with slash (task:39:15587)
--- input
ISBN:978-4-309-22463-3
--- expected
<p><a href="http://d.hatena.ne.jp/asin/4309224636">ISBN:9784309224633</a></p>

=== rakuten
--- skip
not alivable
--- input
[rakuten:book:11833626]
--- expected
<p><a href="http://d.hatena.ne.jp/rakuten/book/11833626">rakuten:book:11833626</a></p>

=== http
--- skip
not alivable
--- input
http://www.hatena.ne.jp/
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">http://www.hatena.ne.jp/</a></p>

=== http brace
--- skip
not alivable
--- input
http://www.hatena.ne.jp/()
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">http://www.hatena.ne.jp/</a>()</p>

=== http brace force
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/()]
--- expected
<p><a href="http://www.hatena.ne.jp/()" target="_blank">http://www.hatena.ne.jp/()</a></p>

=== http title NG
--- skip
not alivable
--- input
http://www.hatena.ne.jp/:title
--- expected
<p><a href="http://www.hatena.ne.jp/:title" target="_blank">http://www.hatena.ne.jp/:title</a></p>

=== http title OK
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:title]
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">¤Ï¤Æ¤Ê</a></p>

=== http title assign
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:title=hatena]
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">hatena</a></p>

=== http image NG
--- skip
not alivable
--- input
http://www.hatena.ne.jp/images/top/h1.gif:image
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif:image" target="_blank">http://www.hatena.ne.jp/images/top/h1.gif:image</a></p>

=== http image OK
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/images/top/h1.gif:image]
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" alt="http://www.hatena.ne.jp/images/top/h1.gif"></a></p>

=== http image:w50
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/images/top/h1.gif:image:w50]
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" alt="http://www.hatena.ne.jp/images/top/h1.gif" width="50"></a></p>

=== http image:h50
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/images/top/h1.gif:image:h50]
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" alt="http://www.hatena.ne.jp/images/top/h1.gif" height="50"></a></p>

=== http image:right
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/images/top/h1.gif:image:right]
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image hatena-image-right" alt="http://www.hatena.ne.jp/images/top/h1.gif"></a></p>

=== http image:left
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/images/top/h1.gif:image:left]
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image hatena-image-left" alt="http://www.hatena.ne.jp/images/top/h1.gif"></a></p>

=== http image:right,w50,h10
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/images/top/h1.gif:image:right,w50,h10]
--- expected
<p><a href="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image" target="_blank"><img src="http://www.hatena.ne.jp/images/top/h1.gif" class="http-image hatena-image-right" alt="http://www.hatena.ne.jp/images/top/h1.gif" width="50" height="10"></a></p>

=== http image screenshot
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-screenshot" target="_blank"><img class="http-screenshot" src="http://screenshot.hatena.ne.jp/images/120x90/c/2/6/b/d/f015f87fcf44a513f4744d853fe22504bc3.jpg" height="90px" width="120px" alt="screenshot" /></a></p>

=== http image screenshot:small
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image:small]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-screenshot" target="_blank"><img class="http-screenshot" src="http://screenshot.hatena.ne.jp/images/80x60/c/2/6/b/d/f015f87fcf44a513f4744d853fe22504bc3.jpg" height="60px" width="80px" alt="screenshot" /></a></p>

=== http image screenshot:large
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image:large]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-screenshot" target="_blank"><img class="http-screenshot" src="http://screenshot.hatena.ne.jp/images/200x150/c/2/6/b/d/f015f87fcf44a513f4744d853fe22504bc3.jpg" height="150px" width="200px" alt="screenshot" /></a></p>

=== http image screenshot:right
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image:right]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-screenshot" target="_blank"><img class="http-screenshot hatena-image-right" src="http://screenshot.hatena.ne.jp/images/120x90/c/2/6/b/d/f015f87fcf44a513f4744d853fe22504bc3.jpg" height="90px" width="120px" alt="screenshot" /></a></p>

=== http image screenshot:left
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image:left]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-screenshot" target="_blank"><img class="http-screenshot hatena-image-left" src="http://screenshot.hatena.ne.jp/images/120x90/c/2/6/b/d/f015f87fcf44a513f4744d853fe22504bc3.jpg" height="90px" width="120px" alt="screenshot" /></a></p>

=== http image screenshot:small,left
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:image:small,left]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-screenshot" target="_blank"><img class="http-screenshot hatena-image-left" src="http://screenshot.hatena.ne.jp/images/80x60/c/2/6/b/d/f015f87fcf44a513f4744d853fe22504bc3.jpg" height="60px" width="80px" alt="screenshot" /></a></p>

=== http barcode (QR code)
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:barcode]
--- expected
<p><a href="http://www.hatena.ne.jp/" class="http-barcode" target="_blank"><img src="http://d.hatena.ne.jp/barcode?str=http%3A%2F%2Fwww%2Ehatena%2Ene%2Ejp%2F" class="http-barcode" alt="http://www.hatena.ne.jp/"></a></p>

=== http detail (1)
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:detail]
--- expected
<p><iframe marginwidth="0" marginheight="0" src="http://b.hatena.ne.jp/entry.parts?url=http%3A%2F%2Fwww%2Ehatena%2Ene%2Ejp%2F" scrolling="no" frameborder="0" height="230" width="500"><div class="hatena-bookmark-detail-info"><a href="http://www.hatena.ne.jp/">¤Ï¤Æ¤Ê</a><a href="http://b.hatena.ne.jp/entry/http%3A%2F%2Fwww%2Ehatena%2Ene%2Ejp%2F">¤Ï¤Æ¤Ê¥Ö¥Ã¥¯¥Þ¡¼¥¯- ¤Ï¤Æ¤Ê</a></div></iframe></p>

=== http detail (2)
--- skip
not alivable
--- input
[http://ja.wikipedia.org/wiki/%E3%81%AF%E3%81%A6%E3%81%AA:detail]
--- expected
<p><iframe marginwidth="0" marginheight="0" src="http://b.hatena.ne.jp/entry.parts?url=http%3A%2F%2Fja%2Ewikipedia%2Eorg%2Fwiki%2F%25E3%2581%25AF%25E3%2581%25A6%25E3%2581%25AA" scrolling="no" frameborder="0" height="230" width="500"><div class="hatena-bookmark-detail-info"><a href="http://ja.wikipedia.org/wiki/%E3%81%AF%E3%81%A6%E3%81%AA">¤Ï¤Æ¤Ê - Wikipedia</a><a href="http://b.hatena.ne.jp/entry/http%3A%2F%2Fja%2Ewikipedia%2Eorg%2Fwiki%2F%25E3%2581%25AF%25E3%2581%25A6%25E3%2581%25AA">¤Ï¤Æ¤Ê¥Ö¥Ã¥¯¥Þ¡¼¥¯- ¤Ï¤Æ¤Ê - Wikipedia</a></div></iframe></p>

=== http sound NG
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/:sound]
--- expected
<p></p>

=== http sound OK
--- skip
not alivable
--- input
[http://www.hatena.ne.jp/some.mp3:sound]
--- expected
<p><span style="vertical-align:middle;">
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="220" height="25" id="mp3_3" align="middle" style="vertical-align:bottom">
<param name="flashVars" value="mp3Url=http://www.hatena.ne.jp/some.mp3">
<param name="allowScriptAccess" value="sameDomain">
<param name="movie" value="http://g.hatena.ne.jp/tools/mp3_3.swf">
<param name="quality" value="high">
<param name="bgcolor" value="#ffffff">
<param name="wmode" value="transparent">
<embed src="http://g.hatena.ne.jp/tools/mp3_3.swf" flashvars="mp3Url=http://www.hatena.ne.jp/some.mp3" quality="high" wmode="transparent" bgcolor="#ffffff" width="220" height="25" name="mp3_3" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" style="vertical-align:bottom">
</object>
<a href="http://www.hatena.ne.jp/some.mp3"><img src="http://g.hatena.ne.jp/images/podcasting.gif" title="Download" alt="Download" border="0" style="border:0px;vertical-align:bottom;"></a>
</span>
</p>

=== http movie (youtube)
--- skip
not alivable
--- input
[http://www.youtube.com/watch?v=UYO_uQR-8PU:movie]
--- expected
<p><object width="425" height="336"><param name="movie" value="http://www.youtube.com/v/UYO_uQR-8PU"></param><param name="wmode" value="transparent"></param><embed src="http://www.youtube.com/v/UYO_uQR-8PU" type="application/x-shockwave-flash" wmode="transparent" width="425" height="336" FlashVars="movie_url=http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU"></embed></object>
<a href="http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (youtube:small)
--- skip
not alivable
--- input
[http://www.youtube.com/watch?v=UYO_uQR-8PU:movie:small]
--- expected
<p><object width="300" height="244"><param name="movie" value="http://www.youtube.com/v/UYO_uQR-8PU"></param><param name="wmode" value="transparent"></param><embed src="http://www.youtube.com/v/UYO_uQR-8PU" type="application/x-shockwave-flash" wmode="transparent" width="300" height="244" FlashVars="movie_url=http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU"></embed></object>
<a href="http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (youtube:w)
--- skip
not alivable
--- input
[http://www.youtube.com/watch?v=UYO_uQR-8PU:movie:w425]
--- expected
<p><object width="425" height="336"><param name="movie" value="http://www.youtube.com/v/UYO_uQR-8PU"></param><param name="wmode" value="transparent"></param><embed src="http://www.youtube.com/v/UYO_uQR-8PU" type="application/x-shockwave-flash" wmode="transparent" width="425" height="336" FlashVars="movie_url=http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU"></embed></object>
<a href="http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (youtube:h)
--- skip
not alivable
--- input
[http://www.youtube.com/watch?v=UYO_uQR-8PU:movie:h336]
--- expected
<p><object width="425" height="336"><param name="movie" value="http://www.youtube.com/v/UYO_uQR-8PU"></param><param name="wmode" value="transparent"></param><embed src="http://www.youtube.com/v/UYO_uQR-8PU" type="application/x-shockwave-flash" wmode="transparent" width="425" height="336" FlashVars="movie_url=http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU"></embed></object>
<a href="http://d.hatena.ne.jp/video/youtube/UYO_uQR-8PU" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (Google Video)
--- skip
not alivable
--- input
[http://video.google.com/videoplay?docid=3475379931344626603:movie]
--- expected
<p><embed style="width: 425px; height: 350px;" id="VideoPlayback" type="application/x-shockwave-flash" src="http://video.google.com/googleplayer.swf?docId=3475379931344626603&hl=en">
<a href="http://d.hatena.ne.jp/video/google/3475379931344626603" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (Google Video:small)
--- skip
not alivable
--- input
[http://video.google.com/videoplay?docid=3475379931344626603:movie:small]
--- expected
<p><embed style="width: 300px; height: 255px;" id="VideoPlayback" type="application/x-shockwave-flash" src="http://video.google.com/googleplayer.swf?docId=3475379931344626603&hl=en">
<a href="http://d.hatena.ne.jp/video/google/3475379931344626603" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (Google Video:w)
--- skip
not alivable
--- input
[http://video.google.com/videoplay?docid=3475379931344626603:movie:w425]
--- expected
<p><embed style="width: 425px; height: 350px;" id="VideoPlayback" type="application/x-shockwave-flash" src="http://video.google.com/googleplayer.swf?docId=3475379931344626603&hl=en">
<a href="http://d.hatena.ne.jp/video/google/3475379931344626603" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (Google Video:h)
--- skip
not alivable
--- input
[http://video.google.com/videoplay?docid=3475379931344626603:movie:h350]
--- expected
<p><embed style="width: 425px; height: 350px;" id="VideoPlayback" type="application/x-shockwave-flash" src="http://video.google.com/googleplayer.swf?docId=3475379931344626603&hl=en">
<a href="http://d.hatena.ne.jp/video/google/3475379931344626603" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (ameba vision)
--- skip
not alivable
--- input
[http://vision.ameba.jp/watch.do?movie=36094:movie]
--- expected
<p><script language="JavaScript" type="text/JavaScript" src="http://visionmovie.ameba.jp/mcj.php?id=SPs52qg75nW:bhabPW:Xc:J0fByDJ/7xqIZQYVN/fkIQPB:PgVhao:4C:HKg4H.05qWZ9rHkSjd&width=425&height=350"></script>
<a href="http://d.hatena.ne.jp/video/ameba/36094" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (ameba vision:small)

--- skip
not alivable
--- input
[http://vision.ameba.jp/watch.do?movie=36094:movie:small]
--- expected
<p><script language="JavaScript" type="text/JavaScript" src="http://visionmovie.ameba.jp/mcj.php?id=SPs52qg75nW:bhabPW:Xc:J0fByDJ/7xqIZQYVN/fkIQPB:PgVhao:4C:HKg4H.05qWZ9rHkSjd&width=300&height=252"></script>
<a href="http://d.hatena.ne.jp/video/ameba/36094" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>


=== http movie (ameba vision:w)
--- skip
not alivable
--- input
[http://vision.ameba.jp/watch.do?movie=36094:movie:w300]
--- expected
<p><script language="JavaScript" type="text/JavaScript" src="http://visionmovie.ameba.jp/mcj.php?id=SPs52qg75nW:bhabPW:Xc:J0fByDJ/7xqIZQYVN/fkIQPB:PgVhao:4C:HKg4H.05qWZ9rHkSjd&width=300&height=252"></script>
<a href="http://d.hatena.ne.jp/video/ameba/36094" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (ameba vision:h)
--- skip
not alivable
--- input
[http://vision.ameba.jp/watch.do?movie=36094:movie:h252]
--- expected
<p><script language="JavaScript" type="text/JavaScript" src="http://visionmovie.ameba.jp/mcj.php?id=SPs52qg75nW:bhabPW:Xc:J0fByDJ/7xqIZQYVN/fkIQPB:PgVhao:4C:HKg4H.05qWZ9rHkSjd&width=300&height=252"></script>
<a href="http://d.hatena.ne.jp/video/ameba/36094" alt="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"><img src="http://d.hatena.ne.jp/images/d_entry.gif" alt="D" border="0" style="vertical-align: bottom;" title="¤³¤ÎÆ°²è¤ò´Þ¤àÆüµ­"></a></p>

=== http movie (flipclip)
--- skip
not alivable
--- input
[http://www.flipclip.net/clips/kiyohero/a6faa0a2db3ad1972dc82609aa684f1f:movie]
--- expected
<p><script type="text/javascript" src="http://www.flipclip.net/js/a6faa0a2db3ad1972dc82609aa684f1f"></script></p>

=== http movie (mp4)
--- skip
not alivable
--- input
[http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4:movie]
--- expected
<p><div style="width:320px; height:256px; cursor:pointer; border:1px solid #999999; background: url(http://g.hatena.ne.jp/images/playmovie.gif) #DDDDDD no-repeat 120px 80px;" onclick="embedQuicktimePlayer(this, 'http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4');"></div>
<a href="http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4" alt="">http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4</a>
</p>

=== http movie (qt)
--- skip
not alivable
--- input
[http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov:movie]
--- expected
<p><div style="width:320px; height:256px; cursor:pointer; border:1px solid #999999; background: url(http://g.hatena.ne.jp/images/playmovie.gif) #DDDDDD no-repeat 120px 80px;" onclick="embedQuicktimePlayer(this, 'http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov');"></div>
<a href="http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov" alt="">http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov</a>
</p>

=== http movie (flv)
--- skip
not alivable
--- input
[http://hatena.g.hatena.ne.jp/files/hatena/9b1db887f36c4deb.flv:movie]
--- expected
<p><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="320" height="265" id="flvplayer" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="http://g.hatena.ne.jp/tools/flvplayer_2.swf" />
<param name="quality" value="high" />
<param name="bgcolor" value="#ffffff" />
<param name="FlashVars" value="moviePath=http://hatena.g.hatena.ne.jp/files/hatena/9b1db887f36c4deb.flv" />
<embed src="http://g.hatena.ne.jp/tools/flvplayer_2.swf" FlashVars="moviePath=http://hatena.g.hatena.ne.jp/files/hatena/9b1db887f36c4deb.flv" quality="high" bgcolor="#ffffff" width="320" height="265" name="flvplayer" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
</p>

=== http movie (force wmp)
--- skip
not alivable
--- input
[http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov:movie=wmp]
--- expected
<p><div style="width:320px; height:309px; cursor:pointer; border:1px solid #999999; background: url(http://g.hatena.ne.jp/images/playmovie.gif) #DDDDDD no-repeat 120px 100px;" onclick="embedWmvPlayer(this, 'http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov');"></div>
<a href="http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov" alt="">http://hatena.g.hatena.ne.jp/files/hatena/7ecac9288b2a126b.mov</a>
</p>

=== http movie (force qt)
--- skip
not alivable
--- input
[http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4:movie=quicktime]
--- expected
<p><div style="width:320px; height:256px; cursor:pointer; border:1px solid #999999; background: url(http://g.hatena.ne.jp/images/playmovie.gif) #DDDDDD no-repeat 120px 80px;" onclick="embedQuicktimePlayer(this, 'http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4');"></div>
<a href="http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4" alt="">http://hatena.g.hatena.ne.jp/files/hatena/4df6ac001b09dfa2.mp4</a>
</p>

=== blockquote
--- skip
not alivable
--- input
>>
°úÍÑ
<<
--- expected
<blockquote>
<p>°úÍÑ</p>
</blockquote>

=== blockquote(url)
--- skip
not alivable
--- input
>http://q.hatena.ne.jp/>
¤Ê¤ó¤Ç¤âÃµ¤·¤Æ¤ß¤Þ¤¹¤Î¤Ç¤­¤¤¤Æ²¼¤µ¤¤¡£
<<
--- expected
<blockquote title="http://q.hatena.ne.jp/" cite="http://q.hatena.ne.jp/">
<p>¤Ê¤ó¤Ç¤âÃµ¤·¤Æ¤ß¤Þ¤¹¤Î¤Ç¤­¤¤¤Æ²¼¤µ¤¤¡£</p>
<cite><a href="http://q.hatena.ne.jp/" target="_blank">http://q.hatena.ne.jp/</a></cite></blockquote>

=== blockquote(autotitle)
--- skip
not alivable
--- input
>http://q.hatena.ne.jp/:title>
¤Ê¤ó¤Ç¤âÃµ¤·¤Æ¤ß¤Þ¤¹¤Î¤Ç¤­¤¤¤Æ²¼¤µ¤¤¡£
<<
--- expected
<blockquote title="¿ÍÎÏ¸¡º÷¤Ï¤Æ¤Ê" cite="http://q.hatena.ne.jp/">
<p>¤Ê¤ó¤Ç¤âÃµ¤·¤Æ¤ß¤Þ¤¹¤Î¤Ç¤­¤¤¤Æ²¼¤µ¤¤¡£</p>
<cite><a href="http://q.hatena.ne.jp/" target="_blank">¿ÍÎÏ¸¡º÷¤Ï¤Æ¤Ê</a></cite></blockquote>

=== blockquote(title)
--- skip
not alivable
--- input
>http://q.hatena.ne.jp/:title=¿ÍÎÏ>
¤Ê¤ó¤Ç¤âÃµ¤·¤Æ¤ß¤Þ¤¹¤Î¤Ç¤­¤¤¤Æ²¼¤µ¤¤¡£
<<
--- expected
<blockquote title="¿ÍÎÏ" cite="http://q.hatena.ne.jp/">
<p>¤Ê¤ó¤Ç¤âÃµ¤·¤Æ¤ß¤Þ¤¹¤Î¤Ç¤­¤¤¤Æ²¼¤µ¤¤¡£</p>
<cite><a href="http://q.hatena.ne.jp/" target="_blank">¿ÍÎÏ</a></cite></blockquote>

=== blockquote(bookmark)
--- skip
not alivable
--- input
>http://www.hatena.ne.jp/:bookmark>
¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©
<<
--- expected
<blockquote title="http://www.hatena.ne.jp/" cite="http://www.hatena.ne.jp/">
<p>¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©</p>
<cite><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a></cite></blockquote>

=== blockquote(bookmark autotitle)
--- skip
not alivable
--- input
>http://www.hatena.ne.jp/:bookmark:title>
¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©
<<
--- expected
<blockquote title="¤Ï¤Æ¤Ê" cite="http://www.hatena.ne.jp/">
<p>¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©</p>
<cite><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/" target="_blank">¤Ï¤Æ¤Ê</a></cite></blockquote>

=== blockquote(autotitle bookmark)
--- skip
not alivable
--- input
>http://www.hatena.ne.jp/:title:bookmark>
¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©
<<
--- expected
<blockquote title="¤Ï¤Æ¤Ê" cite="http://www.hatena.ne.jp/">
<p>¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©</p>
<cite><a href="http://www.hatena.ne.jp/" target="_blank">¤Ï¤Æ¤Ê</a><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a></cite></blockquote>

=== blockquote(bookmark title)
--- skip
not alivable
--- input
>http://www.hatena.ne.jp/:bookmark:title=hatena>
¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©
<<
--- expected
<blockquote title="hatena" cite="http://www.hatena.ne.jp/">
<p>¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©</p>
<cite><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/" target="_blank">hatena</a></cite></blockquote>

=== blockquote(title bookmark)
--- skip
not alivable
--- input
>http://www.hatena.ne.jp/:title=hatena:bookmark>
¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©
<<
--- expected
<blockquote title="hatena" cite="http://www.hatena.ne.jp/">
<p>¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©</p>
<cite><a href="http://www.hatena.ne.jp/" target="_blank">hatena</a><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/" alt="" class="http-bookmark"></a></cite></blockquote>

=== blockquote(><blockquote cite=url)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="*" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">*</a></cite></blockquote>

=== blockquote(><blockquote cite=url:title)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:title"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Ï¤Æ¤Ê" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡© - ¤Ï¤Æ¤Ê</a></cite></blockquote>

=== blockquote(><blockquote cite=url:title=¤Û¤²)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:title=¤Û¤²"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Û¤²" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">¤Û¤²</a></cite></blockquote>

=== blockquote(><blockquote cite=url:title:bookmark)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:title:bookmark"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Ï¤Æ¤Ê" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡© - ¤Ï¤Æ¤Ê</a><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/what" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/what" alt="" class="http-bookmark"></a></cite></blockquote>

=== blockquote(><blockquote cite=url:title=¤Û¤²:bookmark)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:title=¤Û¤²:bookmark"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Û¤²" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">¤Û¤²</a><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/what" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/what" alt="" class="http-bookmark"></a></cite></blockquote>

=== blockquote(><blockquote cite=url:bookmark)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:bookmark"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="*" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/what" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/what" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/what" target="_blank">*</a></cite></blockquote>

=== blockquote(><blockquote cite=url:bookmark:title)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:bookmark:title"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Ï¤Æ¤Ê" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/what" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/what" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/what" target="_blank">¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡© - ¤Ï¤Æ¤Ê</a></cite></blockquote>

=== blockquote(><blockquote cite=url:bookmark:title=¤Û¤²)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:bookmark:title=¤Û¤²"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Û¤²" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://b.hatena.ne.jp/entry/http://www.hatena.ne.jp/what" class="http-bookmark" target="_blank"><img src="http://b.hatena.ne.jp/entry/image/http://www.hatena.ne.jp/what" alt="" class="http-bookmark"></a><a href="http://www.hatena.ne.jp/what" target="_blank">¤Û¤²</a></cite></blockquote>

=== blockquote(><blockquote cite=url title)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what" title="¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">¤Ï¤Æ¤Ê¤Ã¤Æ¤Ê¤Ë¡©</a></cite></blockquote>

=== blockquote(><blockquote cite=url:title title)
--- skip
not alivable
--- input
><blockquote cite="http://www.hatena.ne.jp/what:title" title="¤Û¤²"><
¤Ï¤Æ¤Ê¤È¤Ï
></blockquote><
--- expected
<blockquote title="¤Û¤²" cite="http://www.hatena.ne.jp/what">
<p>¤Ï¤Æ¤Ê¤È¤Ï</p>
<cite><a href="http://www.hatena.ne.jp/what" target="_blank">¤Û¤²</a></cite></blockquote>


=== super pre
--- skip
not alivable
--- input
>||
this is super pre
||<
--- expected
<pre>
this is super pre
</pre>

=== super pre [[]]
--- skip
not alivable
--- input
>||
[[ EXPRESSION ]]
||<
--- expected
<pre>
&#91;&#91; EXPRESSION ]]
</pre>

=== aa
--- skip
not alivable
--- input
>|aa|
this is ascee art
||<
--- expected
<div class="ascii-art">
this is ascee art<br>
</div>

=== syntax highlight
--- skip
not alivable
--- input
>|perl|
use strict;
||<
--- expected
<pre class="syntax-highlight">
<span class="synStatement">use strict</span>;
</pre>

=bn== id
--- input
id:onishi
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/">id:onishi</a></p>

=== id y,m
--- input
id:onishi:200612
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/200612">id:onishi:200612</a></p>

=== id y,m,d
--- input
id:onishi:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214">id:onishi:20061214</a></p>

=== id y,m,d,section(/)
--- input
id:onishi:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214/hoge">id:onishi:20061214:hoge</a></p>

=== id y,m,d,section(#)
--- input
id:onishi:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214#hoge">id:onishi:20061214#hoge</a></p>

=== id y,m,d,section(/num)
--- input
id:onishi:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214/1234567890">id:onishi:20061214:1234567890</a></p>

=== g:id
--- skip
not alivable
--- input
g:oni:id:onishi
--- expected
<p><a href="http://oni.g.hatena.ne.jp/onishi/">g:oni:id:onishi</a></p>

=== g:id y,m
--- skip
not alivable
--- input
g:oni:id:onishi:200612
--- expected
<p><a href="http://oni.g.hatena.ne.jp/onishi/200612">g:oni:id:onishi:200612</a></p>

=== g:id y,m,d
--- skip
not alivable
--- input
g:oni:id:onishi:20061214
--- expected
<p><a href="http://oni.g.hatena.ne.jp/onishi/20061214">g:oni:id:onishi:20061214</a></p>

=== g:id y,m,d,section(/)
--- skip
not alivable
--- input
g:oni:id:onishi:20061214:hoge
--- expected
<p><a href="http://oni.g.hatena.ne.jp/onishi/20061214/hoge">g:oni:id:onishi:20061214:hoge</a></p>

=== g:id y,m,d,section(#)
--- skip
not alivable
--- input
g:oni:id:onishi:20061214#hoge
--- expected
<p><a href="http://oni.g.hatena.ne.jp/onishi/20061214#hoge">g:oni:id:onishi:20061214#hoge</a></p>

=== g:id y,m,d,section(/num)
--- skip
not alivable
--- input
g:oni:id:onishi:20061214:1234567890
--- expected
<p><a href="http://oni.g.hatena.ne.jp/onishi/20061214/1234567890">g:oni:id:onishi:20061214:1234567890</a></p>

=== d:id
--- skip
not alivable
--- input
d:id:onishi
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/">d:id:onishi</a></p>

=== d:id y,m
--- skip
not alivable
--- input
d:id:onishi:200612
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/200612">d:id:onishi:200612</a></p>

=== d:id y,m,d
--- skip
not alivable
--- input
d:id:onishi:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214">d:id:onishi:20061214</a></p>

=== d:id y,m,d,section(/)
--- skip
not alivable
--- input
d:id:onishi:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214/hoge">d:id:onishi:20061214:hoge</a></p>

=== d:id y,m,d,section(#)
--- skip
not alivable
--- input
d:id:onishi:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214#hoge">d:id:onishi:20061214#hoge</a></p>

=== d:id y,m,d,section(/num)
--- skip
not alivable
--- input
d:id:onishi:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214/1234567890">d:id:onishi:20061214:1234567890</a></p>

=== f:id
--- input
f:id:hatenadiary
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/" target="_blank">f:id:hatenadiary</a></p>

=== f:id:fid:image
--- input
f:id:hatenadiary:20041007101545j:image
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image" title="f:id:hatenadiary:20041007101545j:image" class="hatena-fotolife"></a></p>

=== f:id:fid:image:small
--- input
f:id:hatenadiary:20041007101545j:image:small
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545_m.gif" alt="f:id:hatenadiary:20041007101545j:image:small" title="f:id:hatenadiary:20041007101545j:image:small" class="hatena-fotolife"></a></p>

=== f:id:fid:image:medium
--- input
f:id:hatenadiary:20041007101545j:image:medium
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545_120.jpg" alt="f:id:hatenadiary:20041007101545j:image:medium" title="f:id:hatenadiary:20041007101545j:image:medium" class="hatena-fotolife"></a></p>

=== f:id:fid:image:w
--- input
f:id:hatenadiary:20041007101545j:image:w50
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:w50" title="f:id:hatenadiary:20041007101545j:image:w50" class="hatena-fotolife" width="50"></a></p>

=== f:id:fid:image:h
--- input
f:id:hatenadiary:20041007101545j:image:h50
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:h50" title="f:id:hatenadiary:20041007101545j:image:h50" class="hatena-fotolife" height="50"></a></p>

=== f:id:fid:image:right
--- input
f:id:hatenadiary:20041007101545j:image:right
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:right" title="f:id:hatenadiary:20041007101545j:image:right" class="hatena-fotolife hatena-image-right"></a></p>

=== f:id:fid:image:left
--- input
f:id:hatenadiary:20041007101545j:image:left
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:left" title="f:id:hatenadiary:20041007101545j:image:left" class="hatena-fotolife hatena-image-left"></a></p>

=== f:id:fid:image:right,w50,h10
--- input
f:id:hatenadiary:20041007101545j:image:right,w50,h10
--- expected
<p><a href="http://f.hatena.ne.jp/hatenadiary/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/h/hatenadiary/20041007/20041007101545.jpg" alt="f:id:hatenadiary:20041007101545j:image:right,w50,h10" title="f:id:hatenadiary:20041007101545j:image:right,w50,h10" class="hatena-fotolife hatena-image-right" width="50" height="10"></a></p>

=== id (32)
--- input
id:abcdefghijklmnopqrstuvwxyz012345
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/">id:abcdefghijklmnopqrstuvwxyz012345</a></p>

=== id y,m (32)
--- input
id:abcdefghijklmnopqrstuvwxyz012345:200612
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/200612">id:abcdefghijklmnopqrstuvwxyz012345:200612</a></p>

=== id y,m,d (32)
--- input
id:abcdefghijklmnopqrstuvwxyz012345:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214">id:abcdefghijklmnopqrstuvwxyz012345:20061214</a></p>

=== id y,m,d,section(/) (32)
--- input
id:abcdefghijklmnopqrstuvwxyz012345:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214/hoge">id:abcdefghijklmnopqrstuvwxyz012345:20061214:hoge</a></p>

=== id y,m,d,section(#) (32)
--- input
id:abcdefghijklmnopqrstuvwxyz012345:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214#hoge">id:abcdefghijklmnopqrstuvwxyz012345:20061214#hoge</a></p>

=== id y,m,d,section(/num) (32)
--- input
id:abcdefghijklmnopqrstuvwxyz012345:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214/1234567890">id:abcdefghijklmnopqrstuvwxyz012345:20061214:1234567890</a></p>

=== g:id (32)
--- skip
not alivable
--- input
g:oni:id:abcdefghijklmnopqrstuvwxyz012345
--- expected
<p><a href="http://oni.g.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/">g:oni:id:abcdefghijklmnopqrstuvwxyz012345</a></p>

=== g:id y,m (32)
--- skip
not alivable
--- input
g:oni:id:abcdefghijklmnopqrstuvwxyz012345:200612
--- expected
<p><a href="http://oni.g.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/200612">g:oni:id:abcdefghijklmnopqrstuvwxyz012345:200612</a></p>

=== g:id y,m,d (32)
--- skip
not alivable
--- input
g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214
--- expected
<p><a href="http://oni.g.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214">g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214</a></p>

=== g:id y,m,d,section(/) (32)
--- skip
not alivable
--- input
g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214:hoge
--- expected
<p><a href="http://oni.g.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214/hoge">g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214:hoge</a></p>

=== g:id y,m,d,section(#) (32)
--- skip
not alivable
--- input
g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214#hoge
--- expected
<p><a href="http://oni.g.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214#hoge">g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214#hoge</a></p>

=== g:id y,m,d,section(/num) (32)
--- skip
not alivable
--- input
g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214:1234567890
--- expected
<p><a href="http://oni.g.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214/1234567890">g:oni:id:abcdefghijklmnopqrstuvwxyz012345:20061214:1234567890</a></p>

=== d:id (32)
--- skip
not alivable
--- input
d:id:abcdefghijklmnopqrstuvwxyz012345
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/">d:id:abcdefghijklmnopqrstuvwxyz012345</a></p>

=== d:id y,m (32)
--- skip
not alivable
--- input
d:id:abcdefghijklmnopqrstuvwxyz012345:200612
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/200612">d:id:abcdefghijklmnopqrstuvwxyz012345:200612</a></p>

=== d:id y,m,d (32)
--- skip
not alivable
--- input
d:id:abcdefghijklmnopqrstuvwxyz012345:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214">d:id:abcdefghijklmnopqrstuvwxyz012345:20061214</a></p>

=== d:id y,m,d,section(/) (32)
--- skip
not alivable
--- input
d:id:abcdefghijklmnopqrstuvwxyz012345:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214/hoge">d:id:abcdefghijklmnopqrstuvwxyz012345:20061214:hoge</a></p>

=== d:id y,m,d,section(#) (32)
--- skip
not alivable
--- input
d:id:abcdefghijklmnopqrstuvwxyz012345:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214#hoge">d:id:abcdefghijklmnopqrstuvwxyz012345:20061214#hoge</a></p>

=== d:id y,m,d,section(/num) (32)
--- skip
not alivable
--- input
d:id:abcdefghijklmnopqrstuvwxyz012345:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20061214/1234567890">d:id:abcdefghijklmnopqrstuvwxyz012345:20061214:1234567890</a></p>

=== f:id (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/" target="_blank">f:id:abcdefghijklmnopqrstuvwxyz012345</a></p>

=== f:id:fid:image (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545.jpg" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image" class="hatena-fotolife"></a></p>

=== f:id:fid:image:small (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:small
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545_m.gif" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:small" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:small" class="hatena-fotolife"></a></p>

=== f:id:fid:image:w (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:w50
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545.jpg" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:w50" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:w50" class="hatena-fotolife" width="50"></a></p>

=== f:id:fid:image:h (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:h50
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545.jpg" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:h50" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:h50" class="hatena-fotolife" height="50"></a></p>

=== f:id:fid:image:right (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:right
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545.jpg" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:right" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:right" class="hatena-fotolife hatena-image-right"></a></p>

=== f:id:fid:image:left (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:left
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545.jpg" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:left" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:left" class="hatena-fotolife hatena-image-left"></a></p>

=== f:id:fid:image:right,w50,h10 (32)
--- skip
not alivable
--- input
f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:right,w50,h10
--- expected
<p><a href="http://f.hatena.ne.jp/abcdefghijklmnopqrstuvwxyz012345/20041007101545" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/a/abcdefghijklmnopqrstuvwxyz012345/20041007/20041007101545.jpg" alt="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:right,w50,h10" title="f:id:abcdefghijklmnopqrstuvwxyz012345:20041007101545j:image:right,w50,h10" class="hatena-fotolife hatena-image-right" width="50" height="10"></a></p>

=== foomoo
--- skip
not alivable
--- input
foomoo:102161
--- expected
<p><a href="http://www.hotpepper.jp/strJ000000003/?vos=nhppalsa000016">foomoo:102161</a></p>

=== hotpepper
--- skip
not alivable
--- input
hotpepper:102161
--- expected
<p><a href="http://www.hotpepper.jp/strJ000000003/?vos=nhppalsa000016">hotpepper:102161</a></p>

=== tabelog
--- skip
not alivable
--- input
tabelog:102161
--- expected
<p><a href="http://r.tabelog.com/tokyo/A1302/A130203/13028448/">tabelog:102161</a></p>

=== foomoo:title
--- skip
not alivable
--- input
foomoo:102161:title
--- expected
<p><a href="http://www.hotpepper.jp/strJ000000003/?vos=nhppalsa000016">ÉÍÄ®Äâ È¬ÃúËÙÅ¹</a></p>

=== hotpepper:title
--- skip
not alivable
--- input
hotpepper:102161:title
--- expected
<p><a href="http://www.hotpepper.jp/strJ000000003/?vos=nhppalsa000016">ÉÍÄ®Äâ È¬ÃúËÙÅ¹</a></p>

=== tabelog:title
--- skip
not alivable
--- input
tabelog:102161:title
--- expected
<p><a href="http://r.tabelog.com/tokyo/A1302/A130203/13028448/">ÉÍÄ®Äâ È¬ÃúËÙÅ¹</a></p>

=== id+blog
--- skip
not alivable
--- input
id:onishi+zenra
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/">id:onishi+zenra</a></p>

=== id+blog y,m
--- skip
not alivable
--- input
id:onishi+zenra:200612
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/200612">id:onishi+zenra:200612</a></p>

=== id+blog y,m,d
--- skip
not alivable
--- input
id:onishi+zenra:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214">id:onishi+zenra:20061214</a></p>

=== id+blog y,m,d,section(/)
--- skip
not alivable
--- input
id:onishi+zenra:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214/hoge">id:onishi+zenra:20061214:hoge</a></p>

=== id+blog y,m,d,section(#)
--- skip
not alivable
--- input
id:onishi+zenra:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214#hoge">id:onishi+zenra:20061214#hoge</a></p>

=== id+blog y,m,d,section(/num)
--- skip
not alivable
--- input
id:onishi+zenra:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214/1234567890">id:onishi+zenra:20061214:1234567890</a></p>

=== d:id+blog
--- skip
not alivable
--- input
d:id:onishi+zenra
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/">d:id:onishi+zenra</a></p>

=== d:id+blog y,m
--- skip
not alivable
--- input
d:id:onishi+zenra:200612
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/200612">d:id:onishi+zenra:200612</a></p>

=== d:id+blog y,m,d
--- skip
not alivable
--- input
d:id:onishi+zenra:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214">d:id:onishi+zenra:20061214</a></p>

=== d:id+blog y,m,d,section(/)
--- skip
not alivable
--- input
d:id:onishi+zenra:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214/hoge">d:id:onishi+zenra:20061214:hoge</a></p>

=== d:id+blog y,m,d,section(#)
--- skip
not alivable
--- input
d:id:onishi+zenra:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214#hoge">d:id:onishi+zenra:20061214#hoge</a></p>

=== d:id+blog y,m,d,section(/num)
--- skip
not alivable
--- input
d:id:onishi+zenra:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/onishi+zenra/20061214/1234567890">d:id:onishi+zenra:20061214:1234567890</a></p>

=== autolink (new twitter)
--- skip
not alivable
--- input
http://twitter.com/#!/yasuhiro_onishi/status/24191524660
--- expected
<p><a href="http://twitter.com/#!/yasuhiro_onishi/status/24191524660" target="_blank">http://twitter.com/#!/yasuhiro_onishi/status/24191524660</a></p>

=== map
--- skip
not alivable
--- input
map:x139.6980y35.6514:map
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=map&width=200&height=150" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="150" scrolling="no" width="200"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:map</a></iframe></p>

=== map satellite
--- skip
not alivable
--- input
map:x139.6980y35.6514:satellite
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=satellite&width=200&height=150" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="150" scrolling="no" width="200"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:satellite</a></iframe></p>

=== map size(w)
--- skip
not alivable
--- input
map:x139.6980y35.6514:map:w400
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=map&width=400&height=300" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="300" scrolling="no" width="400"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:map:w400</a></iframe></p>

=== map size(h)
--- skip
not alivable
--- input
map:x139.6980y35.6514:satellite:h300
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=satellite&width=400&height=300" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="300" scrolling="no" width="400"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:satellite:h300</a></iframe></p>

=== map (compatible haiku)
--- skip
not alivable
--- input
map:35.6514:139.6980
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=map&width=200&height=150" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="150" scrolling="no" width="200"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:35.6514:139.6980</a></iframe></p>
