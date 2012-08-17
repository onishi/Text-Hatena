use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

plan tests => 1 * blocks;

run_html;


__END__

=== test
--- input
><blockquote>
<p>test</p>
</blockquote><
--- expected
<blockquote>
<p>test</p>
</blockquote>

=== test
--- input
><ins datetime="2010-02-27T00:00:00Z"><
foobar
></ins><
--- expected
<ins datetime="2010-02-27T00:00:00Z">
<p>foobar</p>
</ins>

