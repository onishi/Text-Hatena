package Text::Hatena::Keyword::Parser;
use strict;
use warnings;
use utf8;

use base qw/HTML::Parser Class::Accessor::Lvalue::Fast/;

__PACKAGE__->mk_accessors(qw/html tmp stack depth words re/);

# タグ内のテキストは自動リンクしない
our $no_anchor_tags = join '|', qw/a style textarea script iframe/;

sub initialize {
    my $self = shift;
    my %args = @_;
    $self->re    = undef;
    $self->html  = '';
    $self->tmp   = undef;
    $self->stack = {};
    $self->depth = 0;
    $self->words = $args{words} || {};
    $self->re    = join '|', map { quotemeta } sort { length($b) <=> length($a) } keys %{$self->words || {}};
}

sub start {
    my ($self, $tagname, $attr, $attrseq, $text) = @_;
    $self->depth++;
    $self->format_tmp;

    if ($tagname =~ /^$no_anchor_tags$/i) {
        $self->stack->{no_anchor_tags}->{lc $tagname}++;
    }

    if (defined $attr->{'data-unlink'}) {
        #warn "data-unlink : $text";
        if (!$self->stack->{unlink} || $self->stack->{unlink} < $self->depth) {
            $self->stack->{unlink} = $self->depth;
        }
    }
    $self->html .= $text;
}

sub text {
    my ($self, $text) = @_;
    $self->tmp .= $text;
}

sub end {
    my ($self, $tagname, $text) = @_;
    $self->depth--;
    $self->format_tmp;

    if ($tagname =~ /$no_anchor_tags/i) {
        $self->stack->{no_anchor_tags}->{lc $tagname}--;
        if ($self->stack->{no_anchor_tags}->{lc $tagname} < 1) {
            delete $self->stack->{no_anchor_tags}->{lc $tagname};
        }
    }

    if ($self->stack->{unlink} && $self->stack->{unlink} == $self->depth) {
        delete $self->stack->{unlink};
    }
    $self->html .= $text;
}

sub default {
    my($self, $tagname, $attr, $text) = @_;
    $self->format_tmp;
    $self->html .= $text;
}

sub format_tmp {
    my $self = shift;
    defined $self->tmp or return;
    if (scalar keys %{$self->stack->{no_anchor_tags}}) {
        # a タグの中など
        $self->html .= $self->tmp;
    } elsif ($self->stack->{unlink}) {
        # 自動リンク停止
        $self->html .= $self->tmp;
    } else {
        $self->html .= $self->_format($self->tmp);
    }
    $self->tmp = undef;
}

sub _format {
    my($self, $html) = @_;
    my $re      = $self->re;
    if ($re) {
        $html =~ s{
            (
                \&\#?[A-Za-z0-9]+;
                |
                $re
            )
        }{
            $self->_rewrite($1, $`, $');
        }xeg;
    }
    $html;
}

sub _rewrite {
    my ($self, $word, $before, $after) = @_;
    # 英数字単語境界
    if ($word =~ /^[A-Za-z0-9]/) {
        $before =~ /[A-Za-z0-9]$/ and return $word;
    }
    if ($word =~ /[A-Za-z0-9]$/) {
        $after =~ /^[A-Za-z0-9]/ and return $word;
    }
    $self->words->{$word} || $word;
}

1;
