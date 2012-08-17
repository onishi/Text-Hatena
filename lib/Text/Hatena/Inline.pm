package Text::Hatena::Inline;

use strict;
use warnings;
use HTML::Entities;
use URI::Escape;

use Text::Hatena::Context;

sub new {
    my ($class, %opts) = @_;
    $opts{inlines} ||= [];
    $opts{context} ||= undef;
    bless {
        %opts,
    }, $class;
}

sub inlines {
    my ($self) = @_;
    $self->{inlines};
}

sub format {
    my ($self, $text) = @_;
    $text =~ s{^\n+}{}g;
    my $re = join("|", map { $_->{regexp} } @{ $self->inlines });
    $text =~ s{($re)}{$self->_format($1)}eg;
    $text;
}

sub _format {
    my ($self, $string) = @_;
    my $context = $self->{context};
    for my $inline (@{ $self->inlines }) {
        if (my @matched = ($string =~ $inline->{regexp})) {
            $string = $inline->{block}->($context, @matched);
            last;
        }
    }
    $string;
}

1;
