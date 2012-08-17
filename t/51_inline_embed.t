use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;
use JSON::XS;
use Test::WWW::Stub;

Test::WWW::Stub->register('https://api.twitter.com/1/statuses/oembed.json' => sub {
    return [200, [ 'Content-Type' => 'application/json' ], ['{"provider_name":"Twitter","type":"rich","provider_url":"http:\/\/twitter.com","author_name":"\u4efb\u5929\u5802\u682a\u5f0f\u4f1a\u793e","cache_age":"31536000000","height":null,"author_url":"https:\/\/twitter.com\/Nintendo","html":"\u003Cblockquote class=\"twitter-tweet\" lang=\"ja\"\u003E\u003Cp\u003E3\u670822\u65e5\u767a\u58f2\u4e88\u5b9a\u306e\u300e\u65b0\u30fb\u5149\u795e\u8a71 \u30d1\u30eb\u30c6\u30ca\u306e\u93e1\u300f\u3002\u685c\u4e95\u653f\u535a\u6c0f\u306e\u300e\u793e\u9577\u304c\u8a0a\u304f\u300f\u30a4\u30f3\u30bf\u30d3\u30e5\u30fc\u3092\u672c\u65e5\u3053\u306e\u5f8c\u306b\u63b2\u8f09\u3002\u307e\u305f\u3001\u540c\u3058\u304f\u672c\u65e5\u304b\u3089\u3001\u672c\u4f5c\u306b\u95a2\u3059\u308b\u60c5\u5831\u3092\u304a\u5c4a\u3051\u3059\u308b\u300e\u65b0\u30fb\u5149\u795e\u8a71 \u30d1\u30eb\u30c6\u30ca\u306e\u93e1\u300f\u516c\u5f0fTwitter@3DS_Palutena\u3092\u958b\u8a2d\u3057\u307e\u3059\u3002\u003Ca href=\"https:\/\/twitter.com\/search\/%2523NintendoDirect\"\u003E#NintendoDirect\u003C\/a\u003E\u003C\/p\u003E&mdash; \u4efb\u5929\u5802\u682a\u5f0f\u4f1a\u793e\u3055\u3093 (@Nintendo) \u003Ca href=\"https:\/\/twitter.com\/Nintendo\/status\/172278808970412032\" data-datetime=\"2012-02-22T11:17:23+00:00\"\u003E2\u6708 22, 2012\u003C\/a\u003E\u003C\/blockquote\u003E\n\u003Cscript src=\"\/\/platform.twitter.com\/widgets.js\" charset=\"utf-8\"\u003E\u003C\/script\u003E","version":"1.0","width":550,"url":"https:\/\/twitter.com\/Nintendo\/status\/172278808970412032"}']];
});

plan tests => 1 * blocks();

run_html;

done_testing;

__END__

=== embed
--- input
[embed:https://gist.github.com/1833407]
--- expected
<p><script src="https://gist.github.com/1833407.js"></script></p>

=== tweet
--- input
[tweet https://gist.github.com/1833407]
--- expected
<p><script src="https://gist.github.com/1833407.js"></script></p>

=== tweet lang
--- input
[tweet https://twitter.com/Nintendo/status/172278808970412032 lang='ja']
--- expected
<p><blockquote class="twitter-tweet" lang="ja"><p>3月22日発売予定の『新・光神話 パルテナの鏡』。桜井政博氏の『社長が訊く』インタビューを本日この後に掲載。また、同じく本日から、本作に関する情報をお届けする『新・光神話 パルテナの鏡』公式Twitter@3DS_Palutenaを開設します。<a href="https://twitter.com/search/%2523NintendoDirect">#NintendoDirect</a></p>&mdash; 任天堂株式会社さん (@Nintendo) <a href="https://twitter.com/Nintendo/status/172278808970412032" data-datetime="2012-02-22T11:17:23+00:00">2月 22, 2012</a></blockquote><script src="//platform.twitter.com/widgets.js" charset="utf-8"></script></p>
