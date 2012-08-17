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

=== g:
--- input
g:test
--- expected
<p><a href="http://test.g.hatena.ne.jp/" target="_blank">g:test</a></p>

=== [g:]
--- input
[g:test]
--- expected
<p><a href="http://test.g.hatena.ne.jp/" target="_blank">g:test</a></p>

=== g:about
--- input
[g:test:about]
--- expected
<p><a href="http://test.g.hatena.ne.jp/about" target="_blank">g:test:about</a></p>

=== g:keyword
--- input
[g:test:keyword:はてな]
--- expected
<p><a href="http://test.g.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA" class="okeyword" target="_blank">g:test:keyword:はてな</a></p>

=== g:keyword:presentation
--- input
[g:test:keyword:はてな:presentation]
--- expected
<p><a href="http://test.g.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA?mode=presentation" class="okeyword" target="_blank">g:test:keyword:はてな:presentation</a></p>

=== g:keyword:presentation:mouse
--- input
[g:test:keyword:はてな:presentation:mouse]
--- expected
<p><a href="http://test.g.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA?mode=presentation&mouse=true" class="okeyword" target="_blank">g:test:keyword:はてな:presentation:mouse</a></p>

=== g:id
--- input
g:test:id:onishi
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/" target="_blank">g:test:id:onishi</a></p>

=== g:id:archive
--- input
g:test:id:onishi:archive
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/archive" target="_blank">g:test:id:onishi:archive</a></p>

=== g:id:archive:month
--- input
g:test:id:onishi:archive:201101
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/archive/201101" target="_blank">g:test:id:onishi:archive:201101</a></p>

=== g:id y,m
--- input
g:test:id:onishi:200612
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/200612" target="_blank">g:test:id:onishi:200612</a></p>

=== g:id y,m,d
--- input
g:test:id:onishi:20061214
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/20061214" target="_blank">g:test:id:onishi:20061214</a></p>

=== g:id y,m,d,section(/)
--- input
g:test:id:onishi:20061214:hoge
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/20061214/hoge" target="_blank">g:test:id:onishi:20061214:hoge</a></p>

=== g:id y,m,d,section(#)
--- input
g:test:id:onishi:20061214#hoge
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/20061214#hoge" target="_blank">g:test:id:onishi:20061214#hoge</a></p>

=== g:id y,m,d,section(/num)
--- input
g:test:id:onishi:20061214:1234567890
--- expected
<p><a href="http://test.g.hatena.ne.jp/onishi/20061214/1234567890" target="_blank">g:test:id:onishi:20061214:1234567890</a></p>

=== g:hhh:id:jkondo
--- input
g:hhh:id:jkondo
--- expected
<p><a href="http://hhh.g.hatena.ne.jp/jkondo/" target="_blank">g:hhh:id:jkondo</a></p>

=== g:kkk:id:jkondo
--- input
g:kkk:id:jkondo
--- expected
<p><a href="http://kkk.g.hatena.ne.jp/jkondo/" target="_blank">g:kkk:id:jkondo</a></p>
