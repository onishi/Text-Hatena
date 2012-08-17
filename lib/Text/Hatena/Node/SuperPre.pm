package Text::Hatena::Node::SuperPre;

use strict;
use warnings;
use base qw(Text::Hatena::Node);
use Encode qw(decode_utf8 encode_utf8);
use List::MoreUtils qw(any);
use Text::Hatena::Util;
use Text::VimColor;
use constant {
    BEGINNING => qr/^>\|([^|]*)\|$/,
    ENDOFNODE => qr/^\|\|<$/,
    VIM_OPTIONS => [qw( -RXZ -i NONE -u NONE -N), '+set encoding=utf-8'],
    VIM_PATH => 'vim',
};

our $SUPERPRE_CLASS_NAME = 'code';
our $SUPERPRE_ATTR = '';

sub parse {
    my ($class, $s, $parent, $stack) = @_;
    if ($s->scan(BEGINNING)) {
        my $lang = $s->matched->[1];
        my $content = $s->scan_until(ENDOFNODE);
        pop @$content;
        my $node = $class->new([join("\n", @$content)]);
        $node->{lang} = $lang;
        push @$parent, $node;
        return 1;
    }
}

sub lang { $_[0]->{lang} }

sub as_html {
    my ($self, $context, %opts) = @_;
    my $code = join '', @{ $self->children };
    my $options = {
        class => $SUPERPRE_CLASS_NAME,
        attr => length($SUPERPRE_ATTR) ? " $SUPERPRE_ATTR" : '',
    };
    my $template;

    if ($self->lang && any { $_ eq $self->lang } @{ $context->{available_langs} }) {
        my $content;
        if ($context->{use_vim}) {
            my $vim = Text::VimColor->new(
                filetype => $self->lang,
                vim_path => $ENV{VIM_PATH} || VIM_PATH,
                vim_options => [
                    @{ +VIM_OPTIONS },
                    map {
                        "+set runtimepath+=$_"
                    } @{ $context->{vim_runtimepath} || [] },
                ],
                string => encode_utf8($code),
            );
            $content = decode_utf8($vim->html);
        } else {
            $content = escape_html($code);
        }

        $options = {%$options, lang => escape_html($self->lang), content => $content};
        $template = q[<pre class="{{= $class }} {{= "lang-$lang" }}" data-lang="{{= $lang }}"{{= $attr }}>{{= $content }}</pre>];
    } else {
        $options->{content} = escape_html($code);
        $template = q[<pre class="{{= $class }}"{{= $attr }}>{{= $content }}</pre>];
    }

    $context->_tmpl(__PACKAGE__, $template, $options);
}

1;
__END__



