use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

plan tests => 1 * blocks;

run_html;


__END__

=== test
--- input
[]hoge[]
--- expected
<p><span data-unlink>hoge</span></p>

=== test2
--- input
[]hoge[]fuga
--- expected
<p><span data-unlink>hoge</span>fuga</p>

=== multi line
--- input
[]
hoge
fuga
[]
--- expected
<p>
<span data-unlink><br />
hoge<br />
fuga<br />
</span>
</p>

=== multi line 2
--- input
[]
hoge
fuga
[]
foo
bar
--- expected
<p>
<span data-unlink><br />
hoge<br />
fuga<br />
</span><br />
foo<br />
bar
</p>

=== link
--- input
[]http://www.hatena.ne.jp/[]
--- expected
<p><span data-unlink>http://www.hatena.ne.jp/</span></p>

=== link
--- input
http://www.hatena.ne.jp/
--- expected
<p><a href="http://www.hatena.ne.jp/" target="_blank">http://www.hatena.ne.jp/</a></p>

=== link
--- input
<span>http://www.hatena.ne.jp/</span>
--- expected
<p><span><a href="http://www.hatena.ne.jp/" target="_blank">http://www.hatena.ne.jp/</a></span></p>

