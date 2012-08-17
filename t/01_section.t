use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

plan tests => 1 * blocks;

run_html;


__END__

=== test
--- input
* test1

foo

* test2

bar
--- expected
<div class="section">
<h3>test1</h3>
<p>foo</p>
</div>

<div class="section">
<h3>test2</h3>
<p>bar</p>
</div>


=== test
--- input
* test1

foo

** test1.1

foo!

** test1.2

foo!

*** test1.2.1

foo!

* test2

bar
--- expected
<div class="section">
<h3>test1</h3>
<p>foo</p>

<div class="section">
<h4>test1.1</h4>
<p>foo!</p>
</div>

<div class="section">
<h4>test1.2</h4>
<p>foo!</p>

<div class="section">
<h5>test1.2.1</h5>
<p>foo!</p>
</div>
</div>
</div>

<div class="section">
<h3>test2</h3>
<p>bar</p>
</div>


=== test
--- input
* http://example.com/
foo
--- expected
<div class="section">
<h3><a href="http://example.com/" target="_blank">http://example.com/</a></h3>
<p>foo</p>
</div>

=== heading
--- input
* ***
foobar
--- expected
<div class="section">
	<h3>***</h3>
	<p>foobar</p>
</div>

=== very complex heading
--- input
****foobar
foobar
--- expected
<div class="section">
	<h3>***foobar</h3>
	<p>foobar</p>
</div>

=== very complex heading
--- input
* 
trailing space

** 
trailing space

*** 
trailing space

*
no spaces

**
no spaces

***
no spaces
--- expected
<div class="section">
	<h3></h3>
	<p>trailing space</p>
	<div class="section">
		<h4></h4>
		<p>trailing space</p>

		<div class="section">
			<h5></h5>
			<p>trailing space</p>
		</div>
	</div>
</div>

<div class="section">
	<h3></h3>
	<p>no spaces</p>
</div>

<div class="section">
	<h3>*</h3>
	<p>no spaces</p>
</div>

<div class="section">
	<h3>**</h3>
	<p>no spaces</p>
</div>


=== named
--- input
*hoge_fuga* test1

foo

*123-456* test2

bar

*a.b* test3
baz
--- expected
<div class="section">
<h3 id="hoge_fuga">test1</h3>
<p>foo</p>
</div>

<div class="section">
<h3 id="123-456">test2</h3>
<p>bar</p>
</div>

<div class="section">
<h3>a.b* test3</h3>
<p>baz</p>
</div>
