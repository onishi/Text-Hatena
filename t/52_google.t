use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

plan tests => 1 * blocks();

run_html;


done_testing;

__END__
=== google
--- input
[google:はてな]
--- expected
<p><a href="http://www.google.com/search?q=%E3%81%AF%E3%81%A6%E3%81%AA&ie=utf-8&oe=utf-8" target="_blank">google:はてな</a></p>

=== google:image
--- input
[google:image:はてな]
--- expected
<p><a href="http://images.google.com/images?q=%E3%81%AF%E3%81%A6%E3%81%AA&ie=utf-8&oe=utf-8" target="_blank">google:image:はてな</a></p>

=== google:news
--- input
[google:news:はてな]
--- expected
<p><a href="http://news.google.co.jp/news?q=%E3%81%AF%E3%81%A6%E3%81%AA&ie=utf-8&oe=utf-8" target="_blank">google:news:はてな</a></p>
