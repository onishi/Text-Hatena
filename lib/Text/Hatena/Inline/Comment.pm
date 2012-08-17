package Text::Hatena::Inline::Comment;
use utf8;
use strict;
use warnings;
use Text::Hatena::Inline::DSL;

build_inlines {
    syntax qr{<!--.*-->} => sub {
        my ($context) = @_;
        '<!-- -->';
    };
};

1;
__END__

