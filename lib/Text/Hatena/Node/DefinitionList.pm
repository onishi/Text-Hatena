package Text::Hatena::Node::DefinitionList;

use strict;
use warnings;

use strict;
use warnings;
use base qw(Text::Hatena::Node);
use constant {
    DL => qr/^:([^:]*):(.*)/,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(DL)) {
        my $node = $class->new([ $s->matched->[0] ]);
        until ($s->eos || !$s->scan(DL)) {
            push @$node, $s->matched->[0];
        }
        push @$parent, $node;
        return 1;
    }
}

## NOT COMPATIBLE WITH Hatena Syntax
sub as_struct {
    my ($self, $context) = @_;
    my $ret = [];

    my $children = $self->children;

    for my $line (@$children) {
        if (my ($description) = ($line =~ /^::(.+)/)) {
            push @$ret, +{
                name    => 'dd',
                content => $context->inline->format($description),
            };
        } else {
            my ($title, $description) = ($line =~ /^:([^:]+)(?::(.*))?$/);
            push @$ret, +{
                name => 'dt',
                content => $context->inline->format($title),
            };
            push @$ret, +{
                name => 'dd',
                content => $context->inline->format($description),
            } if $description;
        }
    }

    $ret;
}

sub as_html {
    my ($self, $context, %opts) = @_;

    $context->_tmpl(__PACKAGE__, q[
        <dl>
        ? for (@$items) {
        <{{= $_->{name} }}>{{= $_->{content} }}</{{= $_->{name} }}>
        ? }
        </dl>
    ], {
        items => $self->as_struct($context),
    });
}



1;
__END__



