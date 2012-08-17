use strict;
use warnings;
use lib 'lib';
use lib 't/lib';
use Text::Hatena::Node::SuperPre;
local $Text::Hatena::Node::SuperPre::SUPERPRE_CLASS_NAME = 'printpretty';
use Text::Hatena::Test;
$Text::Hatena::Test::options = { use_vim => 0, available_langs => [qw(perl c)] };

delimiters '###', ':::';

plan tests => 1 * blocks;

run_html;


__END__

### test
::: input
>|perl|
use strict;
use warnings;
warn "helloworld";
||<
::: expected
<pre class="printpretty lang-perl" data-lang="perl">use strict;
use warnings;
warn &quot;helloworld&quot;;</pre>
</pre>

### test
::: input
>|c|
#include <stdio.h>

int main() {
  puts("helloworld");
}
||<
::: expected
<pre class="printpretty lang-c" data-lang="c">#include &lt;stdio.h&gt;

int main() {
  puts(&quot;helloworld&quot;);
}
</pre>
