package Text::Hatena::Keyword;
use strict;
use warnings;
use utf8;

use Regexp::Assemble;
use Text::Hatena::Keyword::Parser;

# タグ内のテキストは自動リンクしない
our $no_anchor_tags = join '|', qw/a style textarea script/;

sub new {
    my $class = shift;
    my %args  = @_;
    my @rules = @{$args{rules} || []};
    my $self  = bless { %args }, $class;
    $self->{rules} = [];
    while (my($key, $value) = splice(@rules, 0, 2)) {
        ref($value) eq 'CODE' or $value = sub {
            sprintf '/keyword/%s', uri_escape($_);
        };
        if (ref($key) eq 'Regexp' || !ref($key)) {
            push @{$self->{rules}}, {
                regexp => $key,
                sub    => $value
            };
        } elsif (ref($key) eq 'ARRAY') {
            my $ra = Regexp::Assemble->new;
            $ra->add(quotemeta $_) for @$key;
            push @{$self->{rules}}, {
                regexp => $ra->re,
                sub    => $value,
            };
        }
    }
    $self;
}

sub extract {
    my($self, $html) = @_;
    my $words = {};
    for my $rule (@{$self->{rules} || []}) {
        my ($regexp, $sub) = ($rule->{regexp}, $rule->{sub});
        for my $word ($html =~ m{($regexp)}g) {
            $words->{$word} //= $sub->($word);
        }
    }
    return $words;
}

sub format {
    my($self, $html, $words) = @_;
    $words ||= $self->extract($html);
    my $parser = $self->parser($words);
    $parser->parse($html);
    $parser->eof;
    $parser->format_tmp;
    $parser->html;
}

sub parser {
    my $self = shift;
    my $words = shift;
    my $parser = Text::Hatena::Keyword::Parser->new();
    $parser->initialize(words => $words);
    return $parser;
}

1;

__END__

=head1 NAME

Text::Hatena::Keyword - Hatena Keyword Linker

=head1 SYNOPSIS

  $parser = Text::Hatena::Keyword->new(
    rules => [
      qr/hoge|fuga/ => sub { sprintf '/keyword/%s', uri_escape($_) },
      [qw/foo bar/] => sub { sprintf '/other/keyword/%s', uri_escape($_) },
    ],
  );
  my $words = $parser->extract($html);
  my $formatted_html = $parser->format($html);

=cut
