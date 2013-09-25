package Text::Hatena::Node::Parser;
use strict;
use warnings;
use utf8;

use base qw/HTML::Parser Class::Accessor::Lvalue::Fast/;

__PACKAGE__->mk_accessors(qw/html stack/);

# タグ内のテキストは自動改行しない
our $no_br_tags = join '|', qw{
datalist
dir
dl
ol
optgroup
option
script
select
server
style
table
tbody
textarea
tfoot
thead
title
tr
ul
};

our $leave_br_tags = join '|', qw{
caption
li
td
th
};

sub is_no_br_tags {
    my ($self, $tag) = @_;
    return $tag =~ m{^(?:$no_br_tags)$}i;
}

sub is_leave_br_tags {
    my ($self, $tag) = @_;
    return $tag =~ m{^(?:$leave_br_tags)$}i;}

sub format {
    my($self, $html) = @_;
    $self->initialize;
    $self->parse($html);
    $self->eof;
    return "<p>" . $self->html . "</p>\n";
}

sub initialize {
    my $self = shift;
    my %args = @_;
    $self->html  = '';
    $self->stack = [];
}

sub start {
    my ($self, $tagname, $attr, $attrseq, $text) = @_;
    if ($self->is_no_br_tags($tagname) || $self->is_leave_br_tags($tagname)) {
        push @{$self->stack}, lc($tagname);
    }
    $self->html .= $text;
}

sub text {
    my ($self, $text) = @_;
    if ($self->is_no_br_tags($self->current_element)) {
        $self->html .= $text;
    } else {

        $self->html .= join(
            "",
            map {
                if (/^(\n\n+)$/) {
                    "</p>" . ("<br />\n" x (length($1) - 2)) . "<p>";
                } else {
                    join("<br />\n", split /\n/, $_, -1);
                }
            } grep {
                $_ ne "\n";
            } split /(\n\n+)/, $text
        );
    }
}

sub end {
    my ($self, $tagname, $text) = @_;
    if (lc($tagname) eq $self->current_element) {
        pop @{$self->stack};
    }
    $self->html .= $text;
}

sub default {
    my($self, $tagname, $attr, $text) = @_;
    $self->html .= $text;
}

sub current_element {
    my $self = shift;
    $self->stack->[-1] || '';
}

1;
