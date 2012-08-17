use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

plan tests => 1 * blocks() + 1;

run_html;

subtest 'footnote object' => sub {
    my $thx = Text::Hatena->new;
    $thx->parse('((foobar)) ((barbaz))');
    eq_or_diff $thx->stash->{footnotes}, [
        {
            'number' => 1,
            'title' => 'foobar',
            'note' => 'foobar'
        },
        {
            'number' => 2,
            'title' => 'barbaz',
            'note' => 'barbaz'
        }
    ];
};

done_testing;


__END__
=== <a href="">
--- input
<a href="http://example.com/">http://example.com/</a>
--- expected
<p>
<a href="http://example.com/">
http://example.com/
</a>
</p>

=== plain http url
--- input
http://example.com/
--- expected
<p>
<a href="http://example.com/" target="_blank">
http://example.com/
</a>
</p>

=== plain mailto uri
--- input
mailto:cho45@lowreal.net
--- expected
<p>
<a href="mailto:cho45@lowreal.net">
cho45@lowreal.net
</a>
</p>

=== url in bracket
--- input
[http://example.com/]
--- expected
<p>
<a href="http://example.com/" target="_blank">
http://example.com/
</a>
</p>

=== unlink
--- input
[]http://example.com/[]
--- expected
<p>
<span data-unlink>http://example.com/</span>
</p>

=== plain http url in antoher element
--- input
<strong>http://example.com/</strong>
--- expected
<p>
<strong>
	<a href="http://example.com/" target="_blank">
	http://example.com/
	</a>
</strong>
</p>

=== plain http url in antoher element
--- input
<q cite="http://example.com/">http://example.com/</q>
--- expected
<p>
<q cite="http://example.com/">
	<a href="http://example.com/" target="_blank">
	http://example.com/
	</a>
</q>
</p>

=== url with port number
--- input
[http://example.com:80/]
--- expected
<p>
<a href="http://example.com:80/" target="_blank">
http://example.com:80/
</a>
</p>

=== barcode
--- input
[http://example.com/:barcode]
--- expected
<p>
<a href="http://example.com/" class="http-barcode" target="_blank"><img src="http://chart.apis.google.com/chart?chs=150x150&cht=qr&chl=http%3A%2F%2Fexample.com%2F" title="http://example.com/"/></a>
</p>

=== link with title
--- input
[http://example.com/:title=Foo bar]
--- expected
<p>
<a href="http://example.com/" target="_blank">
Foo bar
</a>
</p>

=== footnote gkbr: http://d.hatena.ne.jp/hatenadiary/20030315/1047690605
--- input
(((foobar)))
--- expected
<p>
(((foobar)))
</p>

=== escape footnote
--- input
)((foobar))(
--- expected
<p>
((foobar))
</p>

=== footnote
--- input
((foobar)) xxx ((barbaz))
--- expected
<p>
<a href="#f1" name="fn1" title="foobar">*1</a>
xxx
<a href="#f2" name="fn2" title="barbaz">*2</a>
</p>

=== footnote
--- input
((<a href="">foo</a>bar))
--- expected
<p>
<a href="#f1" name="fn1" title="foobar">*1</a>
</p>

=== http + footnote
--- input
[http://example.com/]((foobar))
--- expected
<p>
<a href="http://example.com/" target="_blank">
http://example.com/
</a>
<a href="#f1" name="fn1" title="foobar">*1</a>
</p>

=== [tex:]
--- input
[tex:e^{i\pi} = -1]
--- expected
<p>
<img src="http://chart.apis.google.com/chart?cht=tx&chl=e%5E%7Bi%5Cpi%7D%20%3D%20-1" alt="e^{i\pi} = -1"/>
</p>

=== [tex:] escape
--- input
[tex:\sqrt\[3\]{4}]
--- expected
<p>
<img alt="\sqrt[3]{4}" src="http://chart.apis.google.com/chart?cht=tx&amp;chl=%5Csqrt%5B3%5D%7B4%7D"></img>
</p>
