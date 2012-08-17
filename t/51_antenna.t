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
=== a:id
--- input
a:id:sample
--- expected
<p><a href="http://a.hatena.ne.jp/sample/">a:id:sample</a></p>

=== a:id adjoining Japanese
--- input
a:id:gigi-netのアンテナ
--- expected
<p><a href="http://a.hatena.ne.jp/gigi-net/">a:id:gigi-net</a>のアンテナ</p>
