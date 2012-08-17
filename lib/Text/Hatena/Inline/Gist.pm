package Text::Hatena::Inline::Gist;
use utf8;
use strict;
use warnings;

use Text::Hatena::Inline::DSL;

build_inlines {
    # [gist:___]
    syntax qr{\[gist:([0-9]+)\]}ix => sub {
        my ($context, $id) = @_;
        return qq|<script src="https://gist.github.com/$id.js"></script>|;
    };
};

1;
__END__
