use strict;
use warnings;
use lib glob 'lib t/lib modules/*/lib';
use UNIVERSAL::require;

use Test::More;
use Test::Name::FromLine;

use Text::Hatena::Keyword::Parser;

subtest re => sub {
    my $parser = Text::Hatena::Keyword::Parser->new();
    $parser->initialize(
        words => {
            hoge => 'hoge',
            fuga => 'fuga',
        }
    );
    is $parser->re, 'fuga|hoge';

    $parser->initialize(
        words => {
            '(^_^)' => '(^_^)',
            '[-_-]' => '[-_-]',
        }
    );
    is $parser->re, '\[\-_\-\]|\(\^_\^\)';
};

done_testing;

