package Text::Hatena::Node::Comment;

use strict;
use warnings;
use base qw(Text::Hatena::Node);
use constant {
    BEGINNING => qr/^(.*)<!--.*?(-->)?$/,
    ENDOFNODE => qr/^-->$/,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(BEGINNING)) {
        my $pre = $s->matched->[1];
        push @$parent, $pre;
        unless ($s->matched->[2]) {
            $s->scan_until(ENDOFNODE);
        }

        my $node = $class->new;
        push @$parent, $node;
        return 1;
    }
}

sub as_html {
    my ($self, $context, %opts) = @_;
    '<!-- -->';
}

1;
__END__
