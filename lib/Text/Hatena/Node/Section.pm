package Text::Hatena::Node::Section;

use strict;
use warnings;
use base qw(Text::Hatena::Node);

use Text::Hatena::Util;

use constant {
    SECTION => qr/^(?:
        (\*\*\*?)([^\*].*)     | # *** or **
        (\*)(?:([\w\-]+)\*)?((?!\*\*?[^\*]).*)   # *
    )$/x,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(SECTION)) {
        my $level = length($s->matched->[1] || $s->matched->[3]);
        my $title = $s->matched->[2] || $s->matched->[5];
        my $id    = $s->matched->[4];
        $title =~ s/^\s+|\s+$//g;

        my $node = $class->new;
        $node->{level} = $level;
        $node->{title} = $title;
        $node->{id}    = $id;

        pop @$stack while
            ((ref($stack->[-1]) eq $class) && ($stack->[-1]->level >= $level)) ||
            ($level == 1 && ref($stack->[-1]) eq 'Text::Hatena::Node::SeeMore' && !$stack->[-1]->{is_super});

        $parent = $stack->[-1];

        push @$parent, $node;
        push @$stack, $node;
        return 1;
    }
}

sub level { $_[0]->{level} }
sub title { $_[0]->{title} }
sub id    { $_[0]->{id} }

## NOT COMPATIBLE WITH Hatena Syntax
sub as_html {
    my ($self, $context, %opts) = @_;
    my $level = $self->level;
    my $id = $self->id ? sprintf(' id="%s"', escape_html($self->id)) : '';
    $context->_tmpl(__PACKAGE__, q[
        <div class="section">
            <h{{= $level + 2 }}{{= $id }}>{{= $title }}</h{{= $level + 2 }}>
            {{= $content }}
        </div>
    ], {
        title   => $context->inline->format($self->title),
        level   => $level,
        id      => $id,
        content => $self->SUPER::as_html($context, %opts),
    });
}

1;
__END__
