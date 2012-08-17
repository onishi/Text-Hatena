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

=== k:id:sample
--- input
k:id:sample
--- expected
<p><a href="http://k.hatena.ne.jp/sample/" target="_blank">k:id:sample</a></p>

=== [k:id:sample]
--- input
[k:id:sample]
--- expected
<p><a href="http://k.hatena.ne.jp/sample/" target="_blank">k:id:sample</a></p>

=== [[sample]]
--- input
[[sample]]
--- expected
<p><a href="http://d.hatena.ne.jp/keyword/sample" target="_blank">sample</a></p>

=== [[株式会社はてな]]
--- input
[[株式会社はてな]]
--- expected
<p><a href="http://d.hatena.ne.jp/keyword/%E6%A0%AA%E5%BC%8F%E4%BC%9A%E7%A4%BE%E3%81%AF%E3%81%A6%E3%81%AA" target="_blank">株式会社はてな</a></p>
