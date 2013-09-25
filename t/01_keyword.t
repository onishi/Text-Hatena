use utf8;
use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Keyword::Test;
use utf8;

plan tests => 1 * blocks();

$Text::Hatena::Keyword::Test::options = {
    rules => [
        qr/hoge|ほげ/   => sub { sprintf '[%s]', shift },
        [qw/fuga/] => sub { sprintf '(%s)', shift },
    ]
};

run_html;

#done_testing;

__END__

=== test
--- input
hoge fuga ほげ
--- expected
[hoge] (fuga) [ほげ]

=== tokenize
--- input
hogefugaほげ
--- expected
hogefuga[ほげ]

=== entity
--- input
&hoge;
--- expected
&hoge;

=== tag
--- input
<span>hoge fuga</span>
--- expected
<span>[hoge] (fuga)</span>

=== data-unlink
--- input
<span data-unlink>hoge fuga</span>
--- expected
<span data-unlink>hoge fuga</span>

=== data-unlink nest
--- input
<span data-unlink><span>hoge</span> <span>fuga</span></span>
--- expected
<span data-unlink><span>hoge</span> <span>fuga</span></span>

=== script
--- input
<script>hoge fuga</script>
--- expected
<script>hoge fuga</script>

=== iframe
--- input
<iframe width="312" height="176" src="http://ext.nicovideo.jp/thumb/sm13771590" scrolling="no" style="border:solid 1px #CCC;" frameborder="0"><a href="http://www.nicovideo.jp/watch/sm13771590">【ニコニコ動画】【初音ミク】さよなら忠犬ジュピター【オリジナル】</a></iframe>
--- expected
<iframe width="312" height="176" src="http://ext.nicovideo.jp/thumb/sm13771590" scrolling="no" style="border:solid 1px #CCC;" frameborder="0"><a href="http://www.nicovideo.jp/watch/sm13771590">【ニコニコ動画】【初音ミク】さよなら忠犬ジュピター【オリジナル】</a></iframe>

=== code
--- input
<code>hoge fuga</code>
--- expected
<code>hoge fuga</code>
