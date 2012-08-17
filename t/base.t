
use strict;
use warnings;
use lib 'lib';
use UNIVERSAL::require;

use Test::More;

use Text::Hatena;

my $hatena = Text::Hatena->new;
$hatena->parse('mailto:example@hatena.ne.jp');
is +$hatena->html, '<p><a href="mailto:example@hatena.ne.jp">example@hatena.ne.jp</a></p>' . "\n";

is $hatena->parse('mailto:example@hatena.ne.jp'),
    '<p><a href="mailto:example@hatena.ne.jp">example@hatena.ne.jp</a></p>' . "\n";

$hatena->format('mailto:example@hatena.ne.jp');
is +$hatena->html, '<p><a href="mailto:example@hatena.ne.jp">example@hatena.ne.jp</a></p>' . "\n";

done_testing;

