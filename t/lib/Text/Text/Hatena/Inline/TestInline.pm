package Text::Hatena::Inline::TestInline;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

our $TEST_CODEREF = sub {
    my ($context, $match1) = @_;
    $match1;
};

build_inlines {
    syntax qr{<.*?>(.*)<\/.*?>}ix => $TEST_CODEREF;
};

1;
__END__
