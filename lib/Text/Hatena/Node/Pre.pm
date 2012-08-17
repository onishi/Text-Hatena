package Text::Hatena::Node::Pre;

use strict;
use warnings;
use base qw(Text::Hatena::Node::StopP);
use constant {
    BEGINNING => qr/^>\|$/,
    ENDOFNODE => qr/^(.*?)\|<$/,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(BEGINNING)) {
        my $node = $class->new;
        push @$parent, $node;
        push @$stack, $node;
        return 1;
    }

    if ($s->scan(ENDOFNODE)) {
        push @$parent, $s->matched->[1];
        my $node = pop @$stack;
        ref($node) eq $class or warn sprintf("syntax error: unmatched syntax got:%s expected:%s", ref($node), $class);
        return 1;
    }
}

sub as_html {
    my ($self, $context, %opts) = @_;
    $context->_tmpl(__PACKAGE__, q[
        <pre>{{= $content }}</pre>
    ], {
        content => $self->SUPER::as_html($context, %opts, stopp => 1),
    });
}

1;
__END__
