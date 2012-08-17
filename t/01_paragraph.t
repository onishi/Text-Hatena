use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

plan tests => 1 * blocks;

run_html;


__END__

=== test
--- input
test
--- expected
<p>test</p>

=== test
--- input
test
test
--- expected
<p>test<br />test</p>

=== test
--- input
test
test

test
--- expected
<p>test<br />test</p>
<p>test</p>

=== test
--- input
a


a
--- expected
<p>a</p>
<br />
<p>a</p>

=== test
--- input
a



a
--- expected
<p>a</p>
<br />
<br />
<p>a</p>

=== test
--- input
a




a
--- expected
<p>a</p>
<br />
<br />
<br />
<p>a</p>

