package Text::Hatena::Inline::DSL;

use strict;
use warnings;
use Carp;
use UNIVERSAL::require;

sub import {
    my $class = shift;
    my $pkg   = caller;

    no strict 'refs';
    no warnings 'redefine';
    *{"$pkg\::build_inlines"} = sub (&) { goto &build_inlines };
    *{"$pkg\::enable"} = sub ($) { goto &enable };
    *{"$pkg\::syntax"} = sub ($$;$) { goto &syntax };
}

sub build_inlines {
    my @inlines;
    my $node;
    {
        no strict 'refs';
        no warnings 'redefine';
        local *CORE::GLOBAL::glob = sub {
            ($node) = split /\s+/, shift;
        };
        local *enable = sub {
            push @inlines, _enable(@_);
        };
        local *syntax = sub {
            push @inlines, _syntax(@_, $node);
        };
        $_[0]->();
    }

    # Define inlines() function in $pkg automagically
    # if build_inlines() is called in void context.
    unless (defined wantarray) {
        no strict 'refs';
        no warnings qw/redefine once/;
        my $pkg = caller;
        *{"$pkg\::inlines"} = sub { [@inlines] };
        return 1; # load OK
    }

    [@inlines];
}

sub _enable {
    my ($module_name) = @_;
    my $class = $module_name =~ /::/ ? $module_name : "Text::Hatena::Inline::$module_name";
    $class->use or croak $@;
    my $inlines = $class->inlines;
    @$inlines;
}

sub _syntax {
    my ($regexp, $block, $node) = @_;
    {regexp => $regexp, block => $block, node => $node};
}

sub __stub {
    my $func = shift;
    return sub {
        croak "Can't call $func() outside build_inlines{} block";
    };
}

*enable = __stub 'enable';
*syntax = __stub 'syntax';

1;
__END__

=head1 NAME

Text::Hatena::Inline::DSL

=head1 SYNOPSIS

  my $inlines = build_inlines {
      enable 'MySyntaxName';

      syntax qr{(pattern)} => sub {
          my ($inline, @matches) = $@;
          "replaced string";
      };
  }

  my $inline = Text::Hatena::Inline->new(
      inlines => $inlines,
      stash   => {},
  );

OR

  package Text::Hatena::Inline::MySyntaxName;

  use Text::Hatena::Inline::DSL;

  build_inlines {
      # ...
  };

  1;

=cut
