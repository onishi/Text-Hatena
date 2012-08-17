package Text::Hatena::Node::StopP;

use strict;
use warnings;
use base qw(Text::Hatena::Node);
use constant {
    BEGINNING => qr/^>(<.+>)(<)?$/,
    ENDOFNODE => qr/^(.+>)<$/,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(BEGINNING)) {
        my $node = $class->new([ $s->matched->[1] ]);
        push @$parent, $node;
        if (!$s->matched->[2]) {
            push @$stack, $node;
        }
        return 1;
    }

    if ($s->scan(ENDOFNODE)) {
        my $node = pop @$stack;
        push @$node, $s->matched->[1];
        ref($node) eq $class or warn sprintf("syntax error: unmatched syntax got:%s expected:%s", ref($node), $class);
        return 1;
    }
}

sub as_html {
    my ($self, $context, %opts) = @_;
    $self->SUPER::as_html($context, %opts, stopp => 1);
}

1;
__END__
