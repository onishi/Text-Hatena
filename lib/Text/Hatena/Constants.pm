package Text::Hatena::Constants;

use strict;
use warnings;
use parent qw(Exporter);

our @EXPORT_OK = qw(
    $UNAME_PATTERN
    $BLOGNAME_PATTERN
    $URI_PATTERN
    $GNAME_PATTERN
);

our $UNAME_PATTERN = qr/[a-zA-Z][A-Za-z0-9_\-]{2,31}/;
our $BLOGNAME_PATTERN = qr/[A-Za-z][A-Za-z0-9_\-]{2,31}(?:\+[A-Za-z0-9_]{1,30})?/;
our $GNAME_PATTERN = qr{[a-z][a-z0-9\-]{2,23}};

1;

our $URI_PATTERN = qr{(?:https?|ftp)://[^\s:]+(?::\d+)?[^\s:]+};
