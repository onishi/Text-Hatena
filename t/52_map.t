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
=== map
--- input
map:x139.6980y35.6514:map
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=map&width=200&height=150" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="150" scrolling="no" width="200"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:map</a></iframe></p>

=== map satellite
--- input
map:x139.6980y35.6514:satellite
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=satellite&width=200&height=150" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="150" scrolling="no" width="200"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:satellite</a></iframe></p>

=== map size(w)
--- input
map:x139.6980y35.6514:map:w400
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=map&width=400&height=300" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="300" scrolling="no" width="400"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:map:w400</a></iframe></p>

=== map size(h)
--- input
map:x139.6980y35.6514:satellite:h300
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=satellite&width=400&height=300" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="300" scrolling="no" width="400"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:x139.6980y35.6514:satellite:h300</a></iframe></p>

=== map (compatible haiku)
--- input
map:35.6514:139.6980
--- expected
<p><iframe src="http://map.hatena.ne.jp/frame?x=139.6980&y=35.6514&type=map&width=200&height=150" name="map" marginwidth="0" marginheight="0" vspace="0" hspace="0" frameborder="0" height="150" scrolling="no" width="200"><a href="http://map.hatena.ne.jp/?x=139.6980&y=35.6514&z=4" target="_blank">map:35.6514:139.6980</a></iframe></p>

=== map word
--- input
[map:札幌駅]
--- expected
<p><a href="http://maps.google.co.jp/maps?q=%E6%9C%AD%E5%B9%8C%E9%A7%85" target="_blank">map:札幌駅</a></p>

=== map:t (deprecated)
--- input
[map:t:札幌駅]
--- expected
<p><a href="http://map.hatena.ne.jp/t/%E6%9C%AD%E5%B9%8C%E9%A7%85">map:t:札幌駅</a></p>
