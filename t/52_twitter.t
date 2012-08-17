use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

plan tests => 1 * blocks();

SKIP: {
    skip tests => 1 * blocks();
    run_html;
}

done_testing;

__END__
=== twitter (idcall)
--- input
[twitter:@spam]
--- expected
<p>@<a class="twitter-user-screen-name" href="http://twitter.com/spam">spam</a></p>

=== twitter (tweet)
--- input
[twitter:110179663615229952:tweet]
--- expected
<div class="twitter-tweet">
<p class="twitter-tweet-text">
<span class="twitter-tweet-text-user">@<a class="twitter-user-screen-name" href="http://twitter.com/spam">spam</a>: </span>DMs w/"funny pics," "a pic of you," "a blog about you," or other variants usually link to phishing sites. Tell yr friend to change password.
</p>
<p class="twitter-tweet-info">
<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-tweet-info-permalink"><span class="twitter-tweet-info-date">2011-09-04</span> <span class="twitter-tweet-info-time">11:37:33</span></a> <span class="twitter-tweet-info-source">via web</span>
</p>
</div>

=== twitter (tree)
--- input
[twitter:112063128031870976:tree]
--- expected
<div class="twitter-tree"><div class="twitter-detail twitter-detail-left">
<div class="twitter-detail-user">
<a class="twitter-user-screen-name" href="http://twitter.com/pokutuna">
<img src="http://a0.twimg.com/profile_images/1535395705/__________2011-09-09_13.50.16_normal.png" alt="pokutuna" height="48" width="48">
</a>
</div>
<div class="twitter-detail-tweet">
<p class="twitter-detail-text">
明日会社横のすぐ閉まるカレー食べましょう
</p>
<p class="twitter-detail-info">
<a href="http://twitter.com/pokutuna/status/112062721658327040" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2011-09-09</span> <span class="twitter-detail-info-time">16:20:09</span></a> <span class="twitter-detail-info-source">via <a href="http://sites.google.com/site/yorufukurou/" rel="nofollow">YoruFukurou</a></span>
</p>
</div>
</div><div class="twitter-detail twitter-detail-right">
<div class="twitter-detail-user">
<a class="twitter-user-screen-name" href="http://twitter.com/giginet">
<img src="http://a2.twimg.com/profile_images/1218937202/gigitan_normal.png" alt="giginet" height="48" width="48">
</a>
</div>
<div class="twitter-detail-tweet">
<p class="twitter-detail-text">
@<a class="twitter-user-screen-name" href="http://twitter.com/pokutuna" target="_top">pokutuna</a> たべましょう！
</p>
<p class="twitter-detail-info">
<a href="http://twitter.com/giginet/status/112062786657464320" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2011-09-09</span> <span class="twitter-detail-info-time">16:20:25</span></a> <span class="twitter-detail-info-source">via <a href="http://sites.google.com/site/yorufukurou/" rel="nofollow">YoruFukurou</a></span> to @<a href="http://twitter.com/pokutuna/status/112062721658327040" class="twitter-user-screen-name">pokutuna</a>
</p>
</div>
</div><div class="twitter-detail twitter-detail-left">
<div class="twitter-detail-user">
<a class="twitter-user-screen-name" href="http://twitter.com/pokutuna">
<img src="http://a0.twimg.com/profile_images/1535395705/__________2011-09-09_13.50.16_normal.png" alt="pokutuna" height="48" width="48">
</a>
</div>
<div class="twitter-detail-tweet">
<p class="twitter-detail-text">
@<a class="twitter-user-screen-name" href="http://twitter.com/giginet" target="_top">giginet</a> はい！
</p>
<p class="twitter-detail-info">
<a href="http://twitter.com/pokutuna/status/112062949715214336" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2011-09-09</span> <span class="twitter-detail-info-time">16:21:03</span></a> <span class="twitter-detail-info-source">via <a href="http://sites.google.com/site/yorufukurou/" rel="nofollow">YoruFukurou</a></span> to @<a href="http://twitter.com/giginet/status/112062786657464320" class="twitter-user-screen-name">giginet</a>
</p>
</div>
</div><div class="twitter-detail twitter-detail-right">
<div class="twitter-detail-user">
<a class="twitter-user-screen-name" href="http://twitter.com/giginet">
<img src="http://a2.twimg.com/profile_images/1218937202/gigitan_normal.png" alt="giginet" height="48" width="48">
</a>
</div>
<div class="twitter-detail-tweet">
<p class="twitter-detail-text">
@<a class="twitter-user-screen-name" href="http://twitter.com/pokutuna" target="_top">pokutuna</a> 飛行機もあるし、お土産も買っていきたいので早めが良いです。すぐ閉まるかも知れないしｗ
</p>
<p class="twitter-detail-info">
<a href="http://twitter.com/giginet/status/112063128031870976" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2011-09-09</span> <span class="twitter-detail-info-time">16:21:46</span></a> <span class="twitter-detail-info-source">via <a href="http://sites.google.com/site/yorufukurou/" rel="nofollow">YoruFukurou</a></span> to @<a href="http://twitter.com/pokutuna/status/112062949715214336" class="twitter-user-screen-name">pokutuna</a>
</p>
</div>
</div>
</div>

=== twitter (detail)
--- input
[twitter:110179663615229952:detail]
--- expected
<div class="twitter-detail twitter-detail-left">
<div class="twitter-detail-user">
<a class="twitter-user-screen-name" href="http://twitter.com/spam">
<img src="http://a3.twimg.com/profile_images/1408709905/at-twitter_bigger_normal.png" alt="spam" height="48" width="48">
</a>
</div>
<div class="twitter-detail-tweet">
<p class="twitter-detail-text">
DMs w/"funny pics," "a pic of you," "a blog about you," or other variants usually link to phishing sites. Tell yr friend to change password.
</p>
<p class="twitter-detail-info">
<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2011-09-04</span> <span class="twitter-detail-info-time">11:37:33</span></a> <span class="twitter-detail-info-source">via web</span>
</p>
</div>
</div>

=== twitter (detail:left)
--- input
[twitter:110179663615229952:detail:left]
--- expected
<div class="twitter-detail twitter-detail-left">
<div class="twitter-detail-user">
<a class="twitter-user-screen-name" href="http://twitter.com/spam">
<img src="http://a3.twimg.com/profile_images/1408709905/at-twitter_bigger_normal.png" alt="spam" height="48" width="48">
</a>
</div>
<div class="twitter-detail-tweet">
<p class="twitter-detail-text">
DMs w/"funny pics," "a pic of you," "a blog about you," or other variants usually link to phishing sites. Tell yr friend to change password.
</p>
<p class="twitter-detail-info">
<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2011-09-04</span> <span class="twitter-detail-info-time">11:37:33</span></a> <span class="twitter-detail-info-source">via web</span>
</p>
</div>
</div>

=== twitter (title)
--- input
[twitter:110179663615229952:title]
--- expected
<p><span class="twitter-tweet-title">@<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-user-screen-name">spam</a> / DMs w/"funny pics," "a pic of...</span></p>

=== twitter (title:10)
--- input
[twitter:110179663615229952:title:10]
--- expected
<p><span class="twitter-tweet-title">@<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-user-screen-name">spam</a> / DMs w/"fu...</span></p>

=== twitter url (tweet)
--- input
[http://twitter.com/spam/status/110179663615229952:twitter:tweet]
--- expected
<div class="twitter-tweet">
<p class="twitter-tweet-text">
<span class="twitter-tweet-text-user">@<a class="twitter-user-screen-name" href="http://twitter.com/spam">spam</a>: </span>DMs w/"funny pics," "a pic of you," "a blog about you," or other variants usually link to phishing sites. Tell yr friend to change password.
</p>
<p class="twitter-tweet-info">
<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-tweet-info-permalink"><span class="twitter-tweet-info-date">2011-09-04</span> <span class="twitter-tweet-info-time">11:37:33</span></a> <span class="twitter-tweet-info-source">via web</span>
</p>
</div>

=== twitter shebang url (tweet)
--- input
[http://twitter.com/#!/spam/status/110179663615229952:twitter:tweet]
--- expected
<div class="twitter-tweet">
<p class="twitter-tweet-text">
<span class="twitter-tweet-text-user">@<a class="twitter-user-screen-name" href="http://twitter.com/spam">spam</a>: </span>DMs w/"funny pics," "a pic of you," "a blog about you," or other variants usually link to phishing sites. Tell yr friend to change password.
</p>
<p class="twitter-tweet-info">
<a href="http://twitter.com/spam/status/110179663615229952" class="twitter-tweet-info-permalink"><span class="twitter-tweet-info-date">2011-09-04</span> <span class="twitter-tweet-info-time">11:37:33</span></a> <span class="twitter-tweet-info-source">via web</span>
</p>
</div>
