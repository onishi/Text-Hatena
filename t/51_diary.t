use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

INIT {
    $Text::Hatena::Test::options->{stash} = {
        config => {
            urlbase => 'http://d.hatena.ne.jp/',
        },
    };
}

plan tests => 1 * blocks();

run_html;

done_testing;


__END__

=== id
--- input
d:id:onishi
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/">d:id:onishi</a></p>

=== id y,m
--- input
d:id:onishi:200612
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/200612">d:id:onishi:200612</a></p>

=== id y,m,d
--- input
d:id:onishi:20061214
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214">d:id:onishi:20061214</a></p>

=== id y,m,d,section(/)
--- input
d:id:onishi:20061214:hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214/hoge">d:id:onishi:20061214:hoge</a></p>

=== id y,m,d,section(#)
--- input
d:id:onishi:20061214#hoge
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214#hoge">d:id:onishi:20061214#hoge</a></p>

=== id y,m,d,section(/num)
--- input
d:id:onishi:20061214:1234567890
--- expected
<p><a href="http://d.hatena.ne.jp/onishi/20061214/1234567890">d:id:onishi:20061214:1234567890</a></p>

=== id adjoining Japanese
--- input
d:id:jkondo社長
--- expected
<p><a href="http://d.hatena.ne.jp/jkondo/">d:id:jkondo</a>社長</p>
