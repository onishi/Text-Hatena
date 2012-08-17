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
[amazon:魔法少女まどか☆マギカ]
--- expected
<p><a target="_blank" href="http://www.amazon.co.jp/exec/obidos/external-search?mode=blended&amp;tag=hatena-22&amp;keyword=%E9%AD%94%E6%B3%95%E5%B0%91%E5%A5%B3%E3%81%BE%E3%81%A9%E3%81%8B%E2%98%86%E3%83%9E%E3%82%AE%E3%82%AB">amazon:魔法少女まどか☆マギカ</a></p>
