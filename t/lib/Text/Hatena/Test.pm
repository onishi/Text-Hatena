package Text::Hatena::Test;

use strict;
use warnings;
use Test::Base -Base;
use Test::More;
use HTML::Parser;
use Data::Dumper;
use UNIVERSAL::require;
use HTML::Entities;
use Test::HTML::Differences;

use lib 'lib';
use Text::Hatena;
our $options = {}; # Text::Hatena->new に渡すオプション引数

binmode Test::More->builder->output, ':utf8';

filters {
    input => [qw/chomp/],
    expected => [qw/chomp/],
};

our @EXPORT = qw(run_html thx);

sub thx ($);
sub html ($);

sub run_html (%) {
    my %opts = @_;
    run {
        my ($block) = @_;
        my $input = $block->input;
        my $expected = $block->expected;
        my $skip = $block->skip;
        SKIP: {
            skip "$skip", 1 if $skip;

            if ($opts{linefeed}) {
                $input =~ s/\n/$opts{linefeed}/g;
            }
            my $got = thx $input;
            eq_or_diff_html($got, $expected, $block->name);
        }
    }
}

sub thx ($) {
    my ($str) = @_;
    my $thx = Text::Hatena->new(
        link_target => '_blank',
        %{ $options },
    );
    $thx->parse($str);
    $thx->html;
}


1;
