use utf8;
use strict;
use warnings;
use lib 't/lib';
use Test::Most;
use Text::Hatena::Test;

INIT {
    $Text::Hatena::Test::options->{urlbase} = 'http://test.hatena.ne.jp/';
}

plan tests => 1 * blocks();

run_html;

done_testing;


__END__

=== id
--- input
id:onishi
--- expected
<p><a href="http://test.hatena.ne.jp/onishi/">id:onishi</a></p>

=== id:icon
--- input
id:onishi:icon
--- expected
<p>
  <a class="hatena-id-icon" href="http://test.hatena.ne.jp/onishi/">
    <img alt="id:onishi" class="hatena-id-icon" height="16" src="http://cdn1.www.st-hatena.com/users/on/onishi/profile_s.gif" width="16"></img>
  </a>
</p>

=== id:image
--- input
id:onishi:image
--- expected
<p>
  <a class="hatena-id-image" href="http://test.hatena.ne.jp/onishi/">
    <img alt="id:onishi" class="hatena-id-image" height="60" src="http://cdn1.www.st-hatena.com/users/on/onishi/profile.gif" width="60"></img>
  </a>
</p>

=== id:detail
--- input
id:onishi:detail
--- expected
<p>
  <a href="http://test.hatena.ne.jp/onishi/" class="hatena-id-icon">
    <img src="http://cdn1.www.st-hatena.com/users/on/onishi/profile_s.gif" width="16" height="16" alt="" class="hatena-id-icon">
    id:onishi
  </a>
</p>

=== id:about
--- input
id:onishi:about
--- expected
<p><a href="http://test.hatena.ne.jp/onishi/about">id:onishi:about</a></p>

=== id:archive
--- input
id:onishi:archive
--- expected
<p><a href="http://test.hatena.ne.jp/onishi/archive">id:onishi:archive</a></p>

=== id adjoining Japanese
--- input
id:jkondo社長
--- expected
<p><a href="http://test.hatena.ne.jp/jkondo/">id:jkondo</a>社長</p>

=== id adjoining english
--- input
aid:onishi
--- expected
<p>aid:onishi</p>
