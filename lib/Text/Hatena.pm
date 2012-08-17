package Text::Hatena;

use utf8;
use strict;
use warnings;
use parent qw(Text::Hatena::Context);
use Carp;
use Cache::MemoryCache;

use Text::Hatena::Util;
use Text::Hatena::Inline::Parser;
use Text::Hatena::Inline::DSL;
use Text::Hatena::LineScanner;
use Text::Hatena::Node;
use Text::Hatena::Node::Root;

our $SYNTAXES = [
    'Text::Hatena::Node::SeeMore',
    'Text::Hatena::Node::SuperPre',
    'Text::Hatena::Node::StopP',
    'Text::Hatena::Node::Blockquote',
    'Text::Hatena::Node::Pre',
    'Text::Hatena::Node::List',
    'Text::Hatena::Node::DefinitionList',
    'Text::Hatena::Node::Table',
    'Text::Hatena::Node::Section',
    'Text::Hatena::Node::Comment',
];

our $INLINES = build_inlines {
#    enable 'Unlink';
#    enable 'Footnote';
#    enable 'Comment';
#    enable 'Tag';
    enable 'Embed'; # HTTP より前
    enable 'HTTP';
    enable 'Mailto';
    enable 'TeX';
    enable 'Niconico';
    enable 'Google';
    enable 'HatenaAntenna';
    enable 'HatenaBookmark';
    enable 'HatenaCoco';
    enable 'HatenaFotolife';
    enable 'HatenaQuestion';
    enable 'HatenaGraph';
    enable 'HatenaDiary';
    enable 'HatenaGroup';   # Should come this position
    enable 'HatenaKeyword'; # Should come this position
    enable 'HatenaHaiku';   # Should come this position
    enable 'HatenaId';      # Should come this position
    enable 'Gist';
    enable 'GoogleMap';
    enable 'Amazon';
    enable 'Wikipedia';
};

sub new {
    my ($class, %opts) = @_;
    $opts{syntaxes} ||= $SYNTAXES;
    $opts{inlines}  ||= $INLINES;

    $opts{stash}    ||= {};
    $opts{cache}    ||= Cache::MemoryCache->new({namespace => __PACKAGE__});
    $opts{ua}       ||= LWP::UserAgent->new;
    $opts{lang}     ||= 'en';

    $opts{remove_comment}  //= 1;
    $opts{enable_footnote} //= 1;
    $opts{enable_unlink}   //= 1;
    $opts{use_vim}         //= 1;

    # no languages is available when Text::VimColor is disabled
    $opts{available_langs} = [] unless ($opts{use_vim} || $opts{available_langs});

    my $self = bless {
        %opts
    }, $class;

    $self->{templates} ||= {};
    $self->{templates} = {
        map {
            my $pkg = $_ =~ /::/ ? $_ : "Text::Hatena::Node::$_";
            $pkg => $self->{templates}->{$_};
        }
        keys %{ $self->{templates} }
    };

    $self->{syntaxes} = [
        map {
            my $pkg = $_ =~ /::/ ? $_ : "Text::Hatena::Node::$_";
            $pkg->use or die $@;
            $pkg;
        }
        @{ $opts{syntaxes} || $SYNTAXES }
    ];

    $self;
}

sub html {
    my ($self) = @_;
    $self->{html};
}

sub parse {
    my ($self, $string) = @_;

    # クラスメソッドとしても呼べるように (Text::Hatena 0.20 のインターフェース後方互換)
    ref($self) or $self = $self->new;

    # Parse blocks

    $string =~ s{\r\n?}{\n}g;

    my @syntaxes = @{ $self->{syntaxes} };
    my $s        = Text::Hatena::LineScanner->new($string);
    my $root     = Text::Hatena::Node::Root->new;
    my $stack    = [ $root ];
    loop: until ($s->eos) {
        my $parent = $stack->[-1];

        for my $pkg (@syntaxes) {
            $pkg->parse($s, $parent, $stack) and next loop;
        }

        # Plain lines
        push @$parent, $s->next;
    }

    $self->{root} = $root;

    $self->{html} = $self->{root}->as_html($self);
}

*format = \&parse;

sub inline {
    my $self = shift;
    Text::Hatena::Inline::Parser->new(
        inlines => $self->{inlines},
        context => $self,
    );
}

sub _tmpl {
    my ($self, $pkg, $default, $stash) = @_;
    my $tmpl = $self->{templates}->{$pkg};
    my $sub  = ref($tmpl) eq 'CODE' ? $tmpl : template($tmpl || $default, [ keys %$stash ]);
    $self->{templates}->{$pkg} = $sub;
    $sub->($stash);
}

sub link_target {
    my ($self) = @_;
    $self->{link_target} ? qq{ target="$self->{link_target}"} : '';
}

1;

__END__

=head1 NAME

Text::Hatena - The new "Text-to-HTML converter" with Hatena syntax.

=head1 SYNOPSIS

  use Text::Hatena;

  my $parser = Text::Hatena->new;
  my $html = $parser->parse($string);

  # Text::Hatena 0.16 style
  my $html = $parser->html;

  # Text::Hatena 0.20 style
  my $html = Text::Hatena->parse($string);

  # Text::Xatena style
  my $html = $parser->format($string);

=head1 DESCRIPTION

Text::Hatena is a text-to-html converter.

=head1 SYNTAX



=head1 AUTHOR

L<cho45 E<lt>cho45@lowreal.netE<gt>>

L<onishi E<lt>yasuhiro.onishi@gmail.comE<gt>>

=head1 SEE ALSO

L<Text::Xatena>

L<http://hatenadiary.g.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA%E8%A8%98%E6%B3%95%E4%B8%80%E8%A6%A7>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

