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


=== embed source code from gist.
--- input
[gist:1]
--- expected
<p><script src="https://gist.github.com/1.js"></script></p>
