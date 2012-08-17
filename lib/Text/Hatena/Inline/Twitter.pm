package Text::Hatena::Inline::Twitter;
use utf8;
use strict;
use warnings;

use Text::Hatena::Constants qw($URI_PATTERN);
use Text::Hatena::Inline::DSL;

build_inlines {
    # [twitter:@___]
    # [twitter:___:___]
    # [http://___:twitter:___]
    syntax qr{
        (
            \[?
            (?:
                twitter:@([A-Za-z0-9_]+) # $2 twitter_id
                |
                (?:
                    twitter:(\d+) # $3 tweet_id
                    |
                    https?://twitter.com/[A-Za-z0-9_]+/(?:\#!/)?/status(?:es)?/
                    (\d+) # $4 url_tweet_id
                    :twitter
                )
                :(
                      tweet
                    | tree
                    | detail (?: :left | :right )?
                    | title  (?: :\d{1,3} )?
                ) # $5 opt
            )
            \]?
        ) # $1 name
    }ix => sub {
        my ($context, $name, $twitter_id, $tweet_id, $url_tweet_id, $opt) = @_;
        if (defined $twitter_id) {
            warn $name and return 'TODO: ' . $name;
        }
        else {
            $tweet_id = $url_tweet_id unless defined $tweet_id;
            $opt = lc $opt;
            my ($opt_arg) = ($opt =~ /:(.+)$/);
            if ($opt eq 'tweet') {
                warn $name and return 'TODO:' . $name;
            }
            elsif ($opt eq 'tree') {
                warn $name and return 'TODO:' . $name;
            }
            elsif ($opt =~ /^detail/) {
                warn $name and return 'TODO:' . $name;
            }
            elsif ($opt =~ /^title/) {
                warn $name and return 'TODO:' . $name;
            }
        }
    };
};

1;
