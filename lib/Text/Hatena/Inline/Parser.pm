package Text::Hatena::Inline::Parser;
use strict;
use warnings;

use base qw/HTML::Parser Class::Accessor::Lvalue::Fast/;

use Text::Hatena::Inline;
use HTML::Parser;
use HTML::Tagset;

__PACKAGE__->mk_accessors(qw/inlines context html tmp re inline_nodes stack depth/);

# タグ内のテキストは自動リンクしない
our $no_anchor_tags = join '|', qw/a style textarea script iframe/;

sub new {
    my $class = shift;
    my %args = @_;
    my $inlines = delete $args{inlines} || [];
    my $context = delete $args{context} || undef;
    my $self  = $class->SUPER::new(%args);
    $self->inlines = $inlines;
    $self->context = $context;
    $self->re      = join("|", map { $_->{regexp} } @{ $self->inlines });
    $self->inline_nodes = {
        map { $_->{node} => $_ } grep { $_->{node} } @{ $self->inlines }
    };
    $self->initialize;
    $self;
}

sub initialize {
    my $self = shift;
    $self->html  = '';
    $self->tmp   = undef;
    $self->stack = {};
    $self->depth = 0;
}

sub format {
    my($self, $html) = @_;
    $html =~ s{^\n}{};
    $html = $self->pre_parse($html);
    $self->parse($html);
    $self->eof;
    $self->format_tmp;
    $self->html;
}

sub pre_parse {
    # unlink, footnote だけ先に処理する
    my($self, $html) = @_;
    my $context = $self->context;
    my $enable_footnote = $context->{enable_footnote};
    my $enable_unlink   = $context->{enable_unlink};
    $html =~ s{
        # 脚注回避 )((hoge))( > ((hoge))
        (?<![)]) [)]
        (?<unfootnote>
          [(]{2} (?![(])
          .+?
          (?<![)]) [)]{2}
        )
        [(] (?![(])
        |
        # 脚注 
        (?<![(]) [(]{2} (?![(])
        (?<footnote>.+?)
        (?<![)]) [)]{2} (?![)])
        |
        # 自動リンク停止
        \[\](?<unlink>.*?)\[\]
    }{
        my $result;
        if ($enable_footnote && defined $+{unfootnote}) {
            $result = $+{unfootnote};
        } elsif ($enable_footnote && defined $+{footnote}) {
            my $note = $+{footnote};
            push @{ $context->stash->{footnotes} ||= [] }, {};

            my $number   = @{ $context->stash->{footnotes} };
            my $title    = $note;
            $title =~ s/<[^>]+>//g;

            my $footnote = $context->stash->{footnotes}->[-1];
            $footnote->{number} = $number;
            $footnote->{note}   = $note;
            $footnote->{title}  = $title;
            $result = sprintf(
                '<a href="#f%d" name="fn%d" title="%s">*%d</a>',
                $number,
                $number,
                $title,
                $number
            );
        } elsif ($enable_unlink && defined $+{unlink}) {
            $result = sprintf '<span data-unlink>%s</span>', $+{unlink};
        }
        $result;
    }exmsig;
    $html;
}

sub _format {
    my($self, $html, $attr) = @_;
    my $re      = $self->re;
    my $context = $self->context;
    if ($re) {
        $html =~ s{
            ($re)
        }{
            my $string = $1;
            for my $inline (@{ $self->inlines }) {
                if (my @matched = ($string =~ $inline->{regexp})) {
                    if (%+) {
                        $string = $inline->{block}->($context, $attr);
                    } else {
                        $string = $inline->{block}->($context, @matched);
                    }
                    last;
                }
            }
            $string;
        }xeg;
    }
    $html;
}

sub start {
    my ($self, $tagname, $attr, $attrseq, $text) = @_;
    $self->depth++;
    $self->format_tmp;

    if (defined $attr->{'data-unlink'}) {
        #warn "data-unlink : $text";
        if (!$self->stack->{unlink} || $self->stack->{unlink} < $self->depth) {
            $self->stack->{unlink} = $self->depth;
        }
    }

    if ($HTML::Tagset::isKnown{$tagname}) {
        # known tag
        # TODO attribute (href, src)
        #warn "start: known $tagname\n";
        if ($tagname =~ /^$no_anchor_tags$/i) {
            $self->stack->{no_anchor_tags}->{lc $tagname}++;
        }
        $self->html .= $text;
    } elsif ($tagname =~ /^hatena:\w+$/i) {
        # <hatena:f user="" ... /> / 一番厳密な書き方
        my $inline = $self->inline_nodes->{$tagname};
        if ($inline) {
            $self->html .= $inline->{block}->($self->context, $attr);
        } else {
            # TODO fallback (module etc)
            $self->html .= ref($self->context->{fallback_handler} || '') eq 'CODE'
                ? $self->context->{fallback_handler}->($self, $tagname, $attr, $attrseq, $text)
                : $text;
        }
    } else {
        # unknown tag
        # TODO attribute
        #warn "\nstart: unknown $tagname\n";
        my $syntax;
        if (lc $tagname eq 'hatena') {
            # <hatena f:id:...> / attr が記法
            for my $key (%{$attr || {}}) {
                $key =~ /:/ or next;
                $syntax = $key;
                delete $attr->{$key};
                last;
            }
        } else {
            #<f:id:...> / tagname が記法
            $syntax = $tagname;
        }
        if ($syntax) {
            $syntax =~ s{^hatena:?}{};
            my $formatted = $self->_format($syntax, $attr);
            if ($formatted ne $syntax) {
                $formatted = add_attr($formatted, $attr) if %{$attr || {}};
                $self->html .= $formatted;
            } else {
                # 記法じゃなかった(独自タグ)
                $self->html .= $text;
            }
        } else {
            $self->html .= $text;
        }
    }
    #use YAML;
    #warn Dump [$self, $tagname, $attr, $attrseq, $text];
}

sub text {
    my ($self, $text) = @_;
    $self->tmp .= $text;
}

sub end {
    my ($self, $tagname, $text) = @_;
    $self->format_tmp;

    if ($self->stack->{unlink} && $self->stack->{unlink} == $self->depth) {
        delete $self->stack->{unlink};
    }

    $self->depth--;

    if ($HTML::Tagset::isKnown{$tagname}) {
        # known tag
        #warn "\nend: known $tagname\n";
        if ($tagname =~ /$no_anchor_tags/i) {
            $self->stack->{no_anchor_tags}->{lc $tagname}--;
            if ($self->stack->{no_anchor_tags}->{lc $tagname} < 1) {
                delete $self->stack->{no_anchor_tags}->{lc $tagname};
            }
        }
        $self->html .= $text;
    } else {
        #warn "\nend: unknown $tagname\n";
    }
}

sub comment {
    my ($self, $text) = @_;
    $self->format_tmp;
    #warn "comment : $text";
    if ($self->context->{remove_comment}) {
        $self->html .= '<!-- -->';
    } else {
        $self->html .= "<!--$text-->";
    }
}

sub default {
    my($self, $tagname, $attr, $text) = @_;
    #warn "default : $text";
    $self->format_tmp;
    $self->html .= $text;
}

sub format_tmp {
    my $self = shift;
    # TODO : 自動リンクしないタグ、属性を考慮する
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

sub add_attr {
    my ($html, $add_attr) = @_;
    my ($tags, $result);
    my $parser = HTML::Parser->new(
        api_version => 3,
        start_h     => [
            sub {
                my($self, $tagname, $attr, $attrseq, $text) = @_;
                if ($tags++) {
                    $result .= $text;
                } else {
                    $result = "<$tagname";
                    my %known;
                    for my $a (@$attrseq) {
                        $known{$a}++;
                        my $v = $attr->{$a};
                        my $n = $add_attr->{$a};
                        if ($a eq 'class' && $v && $n) {
                            $v = "$v $n";
                        } elsif ($n) {
                            $v = $n;
                        }
                        $v =~ s/"/&quot;/g;
                        $result .= qq| $a="$v"|;
                    }
                    for my $a (sort keys %{$add_attr || {}}) {
                        $known{$a} and next;
                        my $v = $add_attr->{$a};
                        $result .= qq| $a="$v"|;
                    }
                    $result .= '>';
                }
            },
            'self,tagname,attr,attrseq,text',
        ],
        default_h   => [
            sub {
                my($self, $tagname, $attr, $text) = @_;
                $result .= $text;
            },
            'self,tagname,attr,text',
        ],
    );
    $parser->parse($html);
    $parser->eof;
    return $result;
}

1;

__END__

=head1 NAME

Text::Hatena::Inline::Parser

=head1 SYNOPSIS

  $parser = Text::Hatena::Inline::Parser->new(
      inlines => $inlines,
      context => $context,
  );
  my $formatted_html = $parser->format($html);

=cut
