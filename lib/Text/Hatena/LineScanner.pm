package Text::Hatena::LineScanner;

use strict;
use warnings;

sub new {
    my ($class, $str) = @_;
    my $lines = [ split /\n/, $str ];
    bless {
        matched => undef,
        line    => 0,
        eos     => !@$lines,
        lines   => $lines,
    }, $class;
}

sub scan {
    my $self = shift;
    if (my @matched = ($self->{lines}->[$self->{line}] =~ $_[0])) {
        unshift @matched, $self->{lines}->[$self->{line}];
        $self->{matched} = \@matched;
        $self->{line}++;
        $self->{eos} = ($self->{line} >= @{ $self->{lines} });
        $matched[0];
    } else {
        undef $self->{matched};
    }
}

sub next {
    my $self = shift;
    my $ret = $self->{lines}->[$self->{line}];
    $self->{line}++;
    $self->{eos} = ($self->{line} >= @{ $self->{lines} });
    $ret;
}

sub scan_until {
    my $self = shift;
    my $ret = [];
    until ($self->{eos} || $self->scan($_[0])) {
        push @$ret, $self->{lines}->[$self->{line}];
        $self->{line}++;
        $self->{eos} = ($self->{line} >= @{ $self->{lines} });
    }
    push @$ret, $self->{matched}->[0] if $self->{matched};
    wantarray? @$ret : $ret;
}

sub matched {
    $_[0]->{matched};
}

sub current {
    $_[0]->{lines}->[$_[0]->{line}];
}

sub eos {
    $_[0]->{eos}
}

1;
__END__



