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

=== graph:id
--- input
graph:id:sample
--- expected
<p><a href="http://graph.hatena.ne.jp/sample/" target="_blank">graph:id:sample</a></p>

=== graph:id:graph
--- input
[graph:id:sample:しなもんの体重]
--- expected
<p><a href="http://graph.hatena.ne.jp/sample/%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D/" target="_blank">graph:id:sample:しなもんの体重</a></p>

=== graph:id:graph:image
--- input
[graph:id:sample:しなもんの体重:image]
--- expected
<p>
  <a class="hatena-graph-image" href="http://graph.hatena.ne.jp/sample/%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D/" target="_blank">
    <img
      src="http://graph.hatena.ne.jp/sample/graph?graphname=%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D"
      class="hatena-graph-image"
      alt="しなもんの体重"
      title="しなもんの体重"
    />
</p>

=== graph:id:graph:image:d
--- input
[graph:id:sample:しなもんの体重:image:d30]
--- expected
<p>
  <a class="hatena-graph-image" href="http://graph.hatena.ne.jp/sample/%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D/?day=30" target="_blank">
    <img
      src="http://graph.hatena.ne.jp/sample/graph?graphname=%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D&day=30"
      class="hatena-graph-image"
      alt="しなもんの体重"
      title="しなもんの体重"
    />
</p>

=== graph:id:graph:image:large
--- input
[graph:id:sample:しなもんの体重:image:large]
--- expected
<p>
  <a class="hatena-graph-image" href="http://graph.hatena.ne.jp/sample/%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D/" target="_blank">
    <img
      src="http://graph.hatena.ne.jp/sample/graph?graphname=%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D&mode=detail"
      class="hatena-graph-image"
      alt="しなもんの体重"
      title="しなもんの体重"
    />
</p>

=== graph:id:graph:image:large:d
--- input
[graph:id:sample:しなもんの体重:image:large:d30]
--- expected
<p>
  <a class="hatena-graph-image" href="http://graph.hatena.ne.jp/sample/%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D/?day=30" target="_blank">
    <img
      src="http://graph.hatena.ne.jp/sample/graph?graphname=%E3%81%97%E3%81%AA%E3%82%82%E3%82%93%E3%81%AE%E4%BD%93%E9%87%8D&day=30&mode=detail"
      class="hatena-graph-image"
      alt="しなもんの体重"
      title="しなもんの体重"
    />
</p>

=== graph:t
--- input
[graph:t:体重]
--- expected
<p><a href="http://graph.hatena.ne.jp/t/%E4%BD%93%E9%87%8D" target="_blank">graph:t:体重</a></p>
