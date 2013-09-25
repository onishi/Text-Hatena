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
=== <canvas>
--- input
before<canvas witdh="100" height="100"></canvas>after
--- expected
<p>before<canvas witdh="100" height="100"></canvas>after</p>

=== <section>
--- input
before section<section>section body</section>after section
--- expected
<p>before section<section>section body</section>after section</p>

