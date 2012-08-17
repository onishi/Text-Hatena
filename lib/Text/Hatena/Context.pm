package Text::Hatena::Context;

use strict;
use warnings;
use parent qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(
    stash
    cache
    ua
    lang
));

sub network_enabled { defined $_[0]->ua }

1;
