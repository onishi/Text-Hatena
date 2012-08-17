use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

INIT {
    $Text::Hatena::Test::options->{stash} = {
        link_target => ' target="_blank"',
    };
}

plan tests => 1 * blocks();

run_html;

done_testing;


__END__
=== haiku id
--- input
h:id:onishi
--- expected
<p><a href="http://h.hatena.ne.jp/onishi/" target="_blank">h:id:onishi</a></p>

=== haiku id(2)
--- input
[h:id:onishi]
--- expected
<p><a href="http://h.hatena.ne.jp/onishi/" target="_blank">h:id:onishi</a></p>

=== haiku keyword
--- input
[h:keyword:はてなハイク]
--- expected
<p><a href="http://h.hatena.ne.jp/keyword/%E3%81%AF%E3%81%A6%E3%81%AA%E3%83%8F%E3%82%A4%E3%82%AF" target="_blank">h:keyword:はてなハイク</a></p>

=== h:id adjoining Japanese
--- input
h:id:sampleのハイク
--- expected
<p><a href="http://h.hatena.ne.jp/sample/" target="_blank">h:id:sample</a>のハイク</p>
