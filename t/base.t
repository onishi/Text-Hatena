
use strict;
use warnings;
use lib 'lib';
use UNIVERSAL::require;

use Test::More;

use Text::Hatena;

my $result = '<p><a href="mailto:example@hatena.ne.jp">example@hatena.ne.jp</a></p>' . "\n";

my $hatena = Text::Hatena->new;
$hatena->parse('mailto:example@hatena.ne.jp');
is +$hatena->html, $result, 'new して parse して html';

$hatena = Text::Hatena->new;
is $hatena->parse('mailto:example@hatena.ne.jp'), $result, 'new して parse';

is(Text::Hatena->parse('mailto:example@hatena.ne.jp'), $result, 'クラスメソッドで parse');

is(Text::Hatena->format('mailto:example@hatena.ne.jp'), $result, 'format');

done_testing;

