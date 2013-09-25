package Text::Hatena::Inline::HatenaId;
use utf8;
use strict;
use warnings;

use Text::Hatena::Constants qw($UNAME_PATTERN);
use Text::Hatena::Inline::DSL;

my $SYNTAX_PATTERN = qr{
    (?<![a-zA-Z])
    id:(?<user>$UNAME_PATTERN)
    (?:
        :(?<type>icon|image|detail|archive|about)
    )?
}xi;

build_inlines {
    <hatena:id />;
    # [id:___]
    syntax qr{
        \[ $SYNTAX_PATTERN \] | $SYNTAX_PATTERN
    }ix => sub {
        my ($context, $attr) = @_;
        my ($user, $type) = map { $attr->{$_} // $+{$_} // '' } qw/user type/;
        my $urlbase = $context->{urlbase} || $context->{stash}->{urlbase} || '/';
        if ($type && lc $type eq 'icon') {
            my $pre = substr($user, 0, 2);
            sprintf(
            q{<a href="%s%s/" class="hatena-id-icon"><img src="http://cdn1.www.st-hatena.com/users/%s/%s/profile.gif" width="16" height="16" alt="id:%s" class="hatena-id-icon"></a>},
            $urlbase, $user, $pre, $user, $user);
        } elsif ($type && lc $type eq 'image') {
            my $pre = substr($user, 0, 2);
            sprintf(
            q{<a href="%s%s/" class="hatena-id-image"><img src="http://cdn1.www.st-hatena.com/users/%s/%s/profile.gif" width="60" height="60" alt="id:%s" class="hatena-id-image"></a>},
            $urlbase, $user, $pre, $user, $user);
        } elsif ($type && lc $type eq 'detail') {
            my $pre = substr($user, 0, 2);
            sprintf(
            q{<a href="%s%s/" class="hatena-id-icon"><img src="http://cdn1.www.st-hatena.com/users/%s/%s/profile.gif" width="16" height="16" alt="" class="hatena-id-icon">id:%s</a>},
            $urlbase, $user, $pre, $user, $user);
        } elsif ($type =~ m{about|archive}) {
            sprintf '<a href="%s%s/%s">id:%s:%s</a>', $urlbase, $user, $type, $user, $type;
        } else {
            sprintf '<a href="%s%s/">id:%s</a>', $urlbase, $user, $user;
        }
    };
};

1;
