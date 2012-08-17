use strict;
use warnings;
use lib glob 'lib t/lib modules/*/lib';
use UNIVERSAL::require;

use Test::More;
use Test::Name::FromLine;
use Test::LWP::Stub;

use JSON::XS;

use Text::Hatena::Embed;

my $embed = Text::Hatena::Embed->new;

# oEmbed に行かずに返す
subtest direct => sub {
    is $embed->render('https://gist.github.com/1833407'), '<script src="https://gist.github.com/1833407.js"> </script>', 'gist';

    is $embed->render('http://www.youtube.com/watch?v=KctH2tiRo-M&feature=g-all-pls&context=G2c95300FAAAAAAAAAAA'), '<iframe width="420" height="315" src="http://www.youtube.com/embed/KctH2tiRo-M?wmode=transparent" frameborder="0" allowfullscreen></iframe>', 'YouTubeの動画IDには-も入る';

    is $embed->render('http://ugomemo.hatena.ne.jp/0EB03A80BC7D7DBA@DSi/movie/7DD445_086B8A571518B_000'), '<object data="http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="http://ugomemo.hatena.ne.jp/js/ugoplayer_s.swf"></param><param name="FlashVars" value="did=0EB03A80BC7D7DBA&file=7DD445_086B8A571518B_000"></param></object>', 'ugomemo';

    is $embed->render('http://flipnote.hatena.com/0EB03A80BC7D7DBA@DSi/movie/7DD445_086B8A571518B_000'), '<object data="http://flipnote.hatena.com/js/flipplayer_s.swf" type="application/x-shockwave-flash" width="279" height="240"><param name="movie" value="http://flipnote.hatena.com/js/flipplayer_s.swf"></param><param name="FlashVars" value="did=0EB03A80BC7D7DBA&file=7DD445_086B8A571518B_000"></param></object>', 'flipnote';

    is $embed->render('http://www.nicovideo.jp/watch/sm1128042'), '<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/sm1128042"></script>', 'nicovideo';
};

# request_url 拡張
subtest req_url => sub {
    is $embed->request_url('http://www.flickr.com/photos/bulknews/2752124387/'), 'http://www.flickr.com/services/oembed/?format=json&url=http%3A%2F%2Fwww.flickr.com%2Fphotos%2Fbulknews%2F2752124387%2F', 'オリジナルの request_uri';

    is $embed->request_url('http://matt.wordpress.com/2011/07/14/clouds-over-new-york/'), 'http://public-api.wordpress.com/oembed/?format=json&url=http%3A%2F%2Fmatt.wordpress.com%2F2011%2F07%2F14%2Fclouds-over-new-york%2F&for=Text%3A%3AHatena%3A%3AEmbed', 'wordpress用拡張';

    is $embed->request_url('https://twitter.com/motemen/status/169616501555466242'), 'https://api.twitter.com/1/statuses/oembed.json?url=https%3A%2F%2Ftwitter.com%2Fmotemen%2Fstatus%2F169616501555466242&lang=en', '{format}';

    $embed->lang('ja');
    is $embed->request_url('https://twitter.com/motemen/status/169616501555466242'), 'https://api.twitter.com/1/statuses/oembed.json?url=https%3A%2F%2Ftwitter.com%2Fmotemen%2Fstatus%2F169616501555466242&lang=ja', '{format}';
};

# oEmbed
subtest oembed => sub {
    my $s = Test::LWP::Stub->new;
    $s->register(
        'http://www.flickr.com/services/oembed/?format=json&url=http%3A%2F%2Fwww.flickr.com%2Fphotos%2Fbulknews%2F2752124387%2F' => sub {
            [
                200,
                [ 'Content-Type' => 'application/json' ], [
                    encode_json +{
                        'author_name'   => 'miyagawa',
                        'author_url'    => 'http://www.flickr.com/photos/bulknews/',
                        'cache_age'     => 3600,
                        'height'        => '375',
                        'provider_name' => 'Flickr',
                        'provider_url'  => 'http://www.flickr.com/',
                        'title'         => 'IMG_3069.JPG',
                        'type'          => 'photo',
                        'url'           => 'http://farm4.staticflickr.com/3035/2752124387_873bd71a7b.jpg',
                        'version'       => '1.0',
                        'width'         => '500',
                    }
                ]
            ]
        }
    );

    is $embed->render('http://www.flickr.com/photos/bulknews/2752124387/'), '<img alt="IMG_3069.JPG" height="375" src="http://farm4.staticflickr.com/3035/2752124387_873bd71a7b.jpg" width="500" />', 'flickr';
};

subtest og_image => sub {
    my $s = Test::LWP::Stub->new;
    $s->register(
        'http://instagr.am/p/H5qztakWsT/' => sub {
            [
                200,
                [ 'Content-Type' => 'text/html' ],
                [ '<meta property="og:image" content="http://distilleryimage7.instagram.com/6481b47e68e611e1b9f1123138140926_7.jpg" />
' ]
            ]
        }
    );

    $s->register(
        'http://instagram.com/p/H5qztakWsT/' => sub {
            [
                200,
                [ 'Content-Type' => 'text/html' ],
                [ '<meta property="og:image" content="http://distilleryimage7.instagram.com/6481b47e68e611e1b9f1123138140926_7.jpg" />
' ]
            ]
        }
    );

    is $embed->render('http://instagr.am/p/H5qztakWsT/'), '<a href="http://instagr.am/p/H5qztakWsT/"><img src="http://distilleryimage7.instagram.com/6481b47e68e611e1b9f1123138140926_7.jpg" class="lightbox embed-instagram" alt="" /></a>', 'instagram';

    is $embed->render('http://instagram.com/p/H5qztakWsT/'), '<a href="http://instagram.com/p/H5qztakWsT/"><img src="http://distilleryimage7.instagram.com/6481b47e68e611e1b9f1123138140926_7.jpg" class="lightbox embed-instagram" alt="" /></a>', 'instagram';
};

subtest auto_discovery => sub {
    my $s = Test::LWP::Stub->new;
    $s->register(
        'http://example.com/hoge' => sub {
            [
                200,
                [ 'Content-Type' => 'text/html' ], [
                    '<link rel="alternate" type="application/json+oembed" href="http://example.com/oembed/hoge" />'
                ]
            ]
        }
    );

    $s->register(
        'http://example.com/oembed/hoge' => sub {
            [
                200,
                [ 'Content-Type' => 'application/json' ], [
                    encode_json +{
                        type => 'rich',
                        html => '<strong>hoge</strong>'
                    }
                ]
            ]
        }
    );

    is $embed->request_url('http://example.com/hoge'), 'http://example.com/oembed/hoge';
    is $embed->render('http://example.com/hoge'), '<strong>hoge</strong>';
};

done_testing;

