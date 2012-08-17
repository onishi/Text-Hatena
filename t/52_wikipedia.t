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
=== wikipedia (default)
--- input
[wikipedia:はてな]
--- expected
<p><a href="http://ja.wikipedia.org/wiki/%E3%81%AF%E3%81%A6%E3%81%AA" target="_blank">wikipedia:はてな</a></p>

=== wikipedia (case insensitive)
--- input
[Wikipedia:はてな]
--- expected
<p><a href="http://ja.wikipedia.org/wiki/%E3%81%AF%E3%81%A6%E3%81%AA" target="_blank">Wikipedia:はてな</a></p>

=== wikipedia (en)
--- input
[wikipedia:en:blog]
--- expected
<p><a href="http://en.wikipedia.org/wiki/blog" target="_blank">wikipedia:en:blog</a></p>

=== wikipedia (cbk-zam)
--- input
[wikipedia:cbk-zam:Madonna]
--- expected
<p><a href="http://cbk-zam.wikipedia.org/wiki/Madonna" target="_blank">wikipedia:cbk-zam:Madonna</a></p>
