package Text::Hatena::Node::Table;

use strict;
use warnings;
use base qw(Text::Hatena::Node);
use constant {
    TABLE => qr/^\|/,
};

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(TABLE)) {
        my $a = $class->new([ $s->matched->[0] ]);
        until ($s->eos || !$s->scan(TABLE)) {
            push @$a, $s->matched->[0];
        }
        push @$parent, $a;
        return 1;
    }
}

sub as_struct {
    my ($self, $context) = @_;
    my $ret = [];
    my $children = $self->children;

    for my $line (@$children) {
        my $row = [];
        for my $col (split /\|/, $line) {
            my ($th, $content) = ($col =~ /^(\*)?(.*)$/);
            push @$row, +{
                name     => ($th ? 'th' : 'td'),
                content => $context->inline->format($content),
            };
        }
        shift @$row;
        push @$ret, $row;
    }

    $ret;
}

sub as_html {
    my ($self, $context, %opts) = @_;
    $context->_tmpl(__PACKAGE__, q[
        <table>
        ? for my $row (@$rows) {
            <tr>
        ?   for my $col (@$row) {
            <{{= $col->{name} }}>{{= $col->{content} }}</{{= $col->{name} }}>
        ?   }
            </tr>
        ? }
        </table>
    ], {
        rows => $self->as_struct($context)
    });
}


1;
__END__
