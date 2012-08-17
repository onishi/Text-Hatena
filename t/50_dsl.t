use strict;
use warnings;
use lib 'lib';
use lib 't/lib';
use Test::More tests => 2;
use Test::Deep;
use Text::Hatena::Inline::DSL;
use Data::Dumper;

my $coderef1 = sub {
    my ($context) = @_;
    'OK';
};

my $inlines = build_inlines {
    syntax qr{.*}ix => $coderef1;
};

my $expected = [
    {
        'regexp' => qr{.*}ix,
        'block' => $coderef1,
        'node' => undef,
    }
];

cmp_deeply $inlines, $expected;

my $coderef2;
{
    use Text::Hatena::Inline::TestInline;
    $coderef2 = $Text::Hatena::Inline::TestInline::TEST_CODEREF;
}

my $inlines2 = build_inlines {
    enable 'TestInline';
};

my $expected2 = [
    {
        'regexp' => qr{<.*?>(.*)<\/.*?>}ix,
        'block' => $coderef2,
        'node' => undef,
    }
];

cmp_deeply $inlines2, $expected2;

__END__

