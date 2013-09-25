use strict;
use warnings;
use lib glob 'lib t/lib modules/*/lib';
use UNIVERSAL::require;

use Test::More;
use Test::Name::FromLine;
use Text::Hatena::Node::Parser;

subtest br => sub {
    my $parser = Text::Hatena::Node::Parser->new();
    is $parser->format("hoge\nfuga"), "<p>hoge<br />\nfuga</p>\n", 'normal';
    is $parser->format("hoge\n\nfuga"), "<p>hoge</p><p>fuga</p>\n", 'multi-linefeed';
    is $parser->format("<div>hoge\nfuga</div>"), "<p><div>hoge<br />\nfuga</div></p>\n", 'div';
    is $parser->format("<table>hoge\nfuga</table>"), "<p><table>hoge\nfuga</table></p>\n", 'table';
    is $parser->format("<TABLE>hoge\nfuga</TABLE>"), "<p><TABLE>hoge\nfuga</TABLE></p>\n", 'TABLE';
    is $parser->format("<table><br />\n </table>"), "<p><table><br />\n </table></p>\n", 'br and space in table';
    is $parser->format("<table><br>\n </table>"), "<p><table><br>\n </table></p>\n", 'br and space in table';
    is $parser->format("<table><tr><td>hoge\nfuga</td></tr></table>"), "<p><table><tr><td>hoge<br />\nfuga</td></tr></table></p>\n", 'td in table';
    is $parser->format("<ul><li>hoge\nfuga</li></ul>"), "<p><ul><li>hoge<br />\nfuga</li></ul></p>\n", 'li in ul';
};

done_testing;

