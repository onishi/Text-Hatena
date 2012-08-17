use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

plan tests => 1 * blocks;

run_html;


__END__

=== test
--- input
>|
quote
|<
--- expected
<pre>
quote
</pre>

=== test
--- input
>|
quote1
>>
quote2
<<
|<
--- expected
<pre>
quote1
    <blockquote>
        quote2
    </blockquote>
</pre>

=== test
--- input
>|
http://example.com/
|<
--- expected
<pre>
<a href="http://example.com/" target="_blank">http://example.com/</a>
</pre>

=== test
--- input
>|
quote
|<
test
--- expected
<pre>
quote
</pre>
<p>test</p>

