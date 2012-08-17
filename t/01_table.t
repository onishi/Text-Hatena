use strict;
use warnings;
use lib 't/lib';
use Text::Hatena::Test;

plan tests => 1 * blocks;

run_html;


__END__

=== test
--- input
|*head|*head|*head|
|foo|bar|baz|
|foo|bar|baz|
--- expected
<table>
    <tr>
        <th>head</th>
        <th>head</th>
        <th>head</th>
    </tr>
    <tr>
        <td>foo</td>
        <td>bar</td>
        <td>baz</td>
    </tr>
    <tr>
        <td>foo</td>
        <td>bar</td>
        <td>baz</td>
    </tr>
</table>

=== test
--- input
|*head|*head|*head|
|http://www.lowreal.net/|bar|baz|
--- expected
<table>
    <tr>
        <th>head</th>
        <th>head</th>
        <th>head</th>
    </tr>
    <tr>
        <td><a href="http://www.lowreal.net/" target="_blank">http://www.lowreal.net/</a></td>
        <td>bar</td>
        <td>baz</td>
    </tr>
</table>

=== test
--- input
|*head|*head|*head|
|foo|bar|baz|
|foo|bar|baz|
test
--- expected
<table>
    <tr>
        <th>head</th>
        <th>head</th>
        <th>head</th>
    </tr>
    <tr>
        <td>foo</td>
        <td>bar</td>
        <td>baz</td>
    </tr>
    <tr>
        <td>foo</td>
        <td>bar</td>
        <td>baz</td>
    </tr>
</table>
<p>test</p>

