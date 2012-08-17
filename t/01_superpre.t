use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

$Text::Hatena::Test::options = { use_vim => 1, available_langs => [qw(perl modula2)] };

plan tests => 1 * blocks;

run_html;

__END__

=== test
--- input
>||
test
test
||<
--- expected
<pre class="code">
test
test
</pre>

=== test
--- input
>||
<a href="foobar">foobar</a>
||<
--- expected
<pre class="code">
&lt;a href=&#34;foobar&#34;&gt;foobar&lt;/a&gt;
</pre>

=== test
--- input
>||
>>
foobar
<<
||<
--- expected
<pre class="code">
&gt;&gt;
foobar
&lt;&lt;
</pre>

=== test
--- input
>|perl|
test
test
||<
--- expected
<pre class="code lang-perl" data-lang="perl">
test
test
</pre>

=== test
--- input
>|perl|
test
test
||,
--- expected
<pre class="code lang-perl" data-lang="perl">
test
test
</pre>

=== test
--- input
>||
test
test
||<
test
--- expected
<pre class="code">
test
test
</pre>
<p>test</p>

=== test
--- input
>|modula2|
MODULE sample;
FROM InOut IMPORT WriteLn,WriteString;
BEGIN
   WriteString('This is Modula-2');
   WriteLn
END sample.
||<
--- expected
<pre class="code lang-modula2" data-lang="modula2"><span class="synType">MODULE sample;</span>
<span class="synStatement">FROM</span> InOut <span class="synStatement">IMPORT</span> WriteLn,WriteString;
BEGIN
   WriteString(<span class="synConstant">'This is Modula-2'</span>);
   WriteLn
END sample.
</pre>

=== test
--- input
>|hogelang|
Hi
||<
--- expected
<pre class="code">
Hi
</pre>

=== test
--- input
>|"><xmp|
Hi
||<
--- expected
<pre class="code">
Hi
</pre>

