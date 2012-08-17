package Text::Hatena::Node::List;

use strict;
use warnings;
use base qw(Text::Hatena::Node);
use constant {
    LIST => qr/^([-+]+)\s*(.+)/,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;

    if ($s->scan(LIST)) {
        my $node = $class->new([ $s->matched ]);
        until ($s->eos || !$s->scan(LIST)) {
            push @$node, $s->matched;
        }
        push @$parent, $node;
        return 1;
    }
}

sub as_struct {
    my ($self) = @_;

    my $ret   = [];
    my $stack = []; # ol ul stack (that is, exluding li)

    for my $child (@{ $self->children }) {
        my ($line, $symbol, $text) = @$child;
        my $level = length($symbol);
        my $type  = substr($line, $level - 1, 1) eq '+' ? 'ol' : 'ul';

        while ($level < @$stack) {
            pop @$stack;
        }

        pop @$stack if @$stack == $level && $stack->[-1]->{name} ne $type;

        while (@$stack < $level) {
            my $container = +{
                name     => $type,
                items => []
            };

            if (@$stack) {
                if ($stack->[-1]->{items}->[-1]) {
                    push @{ $stack->[-1]->{items}->[-1]->{children} }, $container;
                } else {
                    my $item = {
                        name => 'li',
                        children => [ $container ],
                    };
                    push @{ $stack->[-1]->{items} }, $item;
                }
            } else {
                push @$ret, $container;
            }
            push @$stack, $container;
        }

        my $item = {
            name     => 'li',
            children => [ $text ],
        };

        push @{ $stack->[-1]->{items} }, $item;
    }

    $ret;
}

sub as_html {
    my ($self, $context, %opts) = @_;
    my $ret = '';
    for my $list (@{ $self->as_struct }) {
        $ret .= $self->_as_html($context, $list, %opts);
    }
    $ret;
}

sub _as_html {
    my ($self, $context, $list, %opts) = @_;

    $context->_tmpl(__PACKAGE__, q[
        <{{= $name }}>
        ? for (@$items) {
        <li>{{= $_ }}</li>
        ? }
        </{{= $name }}>
    ], {
        name  => $list->{name},
        items => [
            map {
                join('',
                    map {
                        if (ref($_)) {
                            $self->_as_html($context, $_, %opts)
                        } else {
                            $context->inline->format($_)
                        }
                    }
                    @{ $_->{children} }
                )
            }
            @{ $list->{items} }
        ]
    });
}


1;
__END__



