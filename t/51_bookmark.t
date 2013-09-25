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
=== b:id
--- input
b:id:sample
--- expected
<p><a href="http://b.hatena.ne.jp/sample/">b:id:sample</a></p>

=== b:id:date
--- input
b:id:sample:20050707
--- expected
<p><a href="http://b.hatena.ne.jp/sample/20050707">b:id:sample:20050707</a></p>

=== b:id:entry 1
--- input
b:id:entry:1
--- expected
<p><a href="http://b.hatena.ne.jp/entry/1">b:id:entry:1</a></p>

=== b:id:entry 2
--- input
b:id:entry:123456789
--- expected
<p><a href="http://b.hatena.ne.jp/entry/123456789">b:id:entry:123456789</a></p>

=== b:id:favorite
--- input
b:id:sample:favorite
--- expected
<p><a href="http://b.hatena.ne.jp/sample/favorite">b:id:sample:favorite</a></p>

=== b:id:asin
--- input
b:id:sample:asin
--- expected
<p><a href="http://b.hatena.ne.jp/sample/asin">b:id:sample:asin</a></p>

=== b:id:tag
--- input
[b:id:sample:t:hatena]
--- expected
<p><a href="http://b.hatena.ne.jp/sample/hatena/">b:id:sample:t:hatena</a></p>

=== b:tag
--- input
[b:t:hatena]
--- expected
<p><a href="http://b.hatena.ne.jp/t/hatena">b:t:hatena</a></p>

=== b:keyword
--- input
[b:keyword:はてな]
--- expected
<p><a href="http://b.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA">b:keyword:はてな</a></p>

=== b:id include Japanese
--- input
b:id:sampleのブックマーク
--- expected
<p><a href="http://b.hatena.ne.jp/sample/">b:id:sample</a>のブックマーク</p>
