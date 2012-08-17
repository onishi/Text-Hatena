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
=== question:id
--- input
question:1143254541
--- expected
<p><a href="http://q.hatena.ne.jp/1143254541" target="_blank">question:1143254541</a></p>

=== question:id:title
--- skip
cannot fetch title
--- input
question:1143254541:title
--- expected
<p><a href="http://q.hatena.ne.jp/1143254541" target="_blank">今年はなぜか花粉症にほとんどなりません。
どこかで誰かが貢献していたりしますか？</a></p>

=== question:id:title=
--- input
[question:1143254541:title=こんな質問]
--- expected
<p><a href="http://q.hatena.ne.jp/1143254541" target="_blank">こんな質問</a></p>

=== question:id
--- input
question:1142238823
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823" target="_blank">question:1142238823</a></p>

=== question:id:title
--- skip
cannot fetch title
--- input
question:1142238823:title
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823" target="_blank">人力検索はてなをリニューアルしたけどどうですか？</a></p>

=== question:id:qN
--- input
question:1142238823:q2
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823#eq02" target="_blank">question:1142238823:q2</a></p>

=== question:id:qN:title
--- skip
cannot fetch title
--- input
question:1142238823:q2:title
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823#eq02" target="_blank">ここが良い</a></p>

=== question:id:detail
--- skip
cannot fetch detail
--- input
question:1142238823:detail
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823" target="_blank">人力検索はてなをリニューアルしたけどどうですか？</a></p>
<table class="hatena-question-detail">
<tbody><tr>
<th colspan="2" class="hatena-question-detail-title"><a href="http://q.hatena.ne.jp/1142238823#eq01" target="_blank">前と比べて</a></th>
</tr>
<tr>
<td class="hatena-question-detail-label">良くなった</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="90%" class="hatena-question-detail-graph" alt="" title=""> 622</td>
</tr>
<tr>
<td class="hatena-question-detail-label">悪くなった</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="39%" class="hatena-question-detail-graph" alt="" title=""> 272</td>
</tr>
<tr>
<td class="hatena-question-detail-label">特に変わらない</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="15%" class="hatena-question-detail-graph" alt="" title=""> 106</td>
</tr>
</tbody></table>

<table class="hatena-question-detail">
<tbody><tr>
<th colspan="2" class="hatena-question-detail-title"><a href="http://q.hatena.ne.jp/1142238823#eq02" target="_blank">ここが良い</a></th>
</tr>
<tr>
<td class="hatena-question-detail-label">いわし質問</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="10%" class="hatena-question-detail-graph" alt="" title=""> 94</td>
</tr>
<tr>
<td class="hatena-question-detail-label">複数アンケート</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="90%" class="hatena-question-detail-graph" alt="" title=""> 846</td>
</tr>
<tr>
<td class="hatena-question-detail-label">いるか賞</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="15%" class="hatena-question-detail-graph" alt="" title=""> 142</td>
</tr>
<tr>
<td class="hatena-question-detail-label">回答を見る順番を選べる</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="18%" class="hatena-question-detail-graph" alt="" title=""> 177</td>
</tr>
<tr>
<td class="hatena-question-detail-label">はてな記法</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="11%" class="hatena-question-detail-graph" alt="" title=""> 111</td>
</tr>
</tbody></table>

=== question:id:image
--- skip
cannot fetch image
--- input
question:1142238823:image
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823#eq01" class="hatena-question-image" target="_blank"><img src="http://q.hatena.ne.jp/enquetegraph?qid=1142238823&amp;qnum=1&amp;h=140&amp;w=480" class="hatena-question-image"></a>
<a href="http://q.hatena.ne.jp/1142238823#eq02" class="hatena-question-image" target="_blank"><img src="http://q.hatena.ne.jp/enquetegraph?qid=1142238823&amp;qnum=2&amp;h=140&amp;w=480" class="hatena-question-image"></a></p>

=== question:id:image:smaill
--- skip
cannot fetch image
--- input
question:1142238823:image:small
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823#eq01" class="hatena-question-image" target="_blank"><img src="http://q.hatena.ne.jp/enquetegraph?qid=1142238823&amp;qnum=1&amp;h=140&amp;w=480" class="hatena-question-image"></a>
<a href="http://q.hatena.ne.jp/1142238823#eq02" class="hatena-question-image" target="_blank"><img src="http://q.hatena.ne.jp/enquetegraph?qid=1142238823&amp;qnum=2&amp;h=140&amp;w=480" class="hatena-question-image"></a></p>

=== question:id:qN:detail
--- skip
cannot fetch detail
--- input
question:1142238823:q2:detail
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823" target="_blank">人力検索はてなをリニューアルしたけどどうですか？</a></p>
<table class="hatena-question-detail">
<tbody><tr>
<th colspan="2" class="hatena-question-detail-title"><a href="http://q.hatena.ne.jp/1142238823#eq02" target="_blank">ここが良い</a></th>
</tr>
<tr>
<td class="hatena-question-detail-label">いわし質問</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="10%" class="hatena-question-detail-graph" alt="" title=""> 94</td>
</tr>
<tr>
<td class="hatena-question-detail-label">複数アンケート</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="90%" class="hatena-question-detail-graph" alt="" title=""> 846</td>
</tr>
<tr>
<td class="hatena-question-detail-label">いるか賞</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="15%" class="hatena-question-detail-graph" alt="" title=""> 142</td>
</tr>
<tr>
<td class="hatena-question-detail-label">回答を見る順番を選べる</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="18%" class="hatena-question-detail-graph" alt="" title=""> 177</td>
</tr>
<tr>
<td class="hatena-question-detail-label">はてな記法</td>
<td class="hatena-question-detail-value"><img src="http://www.hatena.ne.jp/images/red.gif" height="10" width="11%" class="hatena-question-detail-graph" alt="" title=""> 111</td>
</tr>
</tbody></table>

=== question:qN:image
--- skip
cannot fetch image
--- input
question:1142238823:q2:image
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823#eq02" class="hatena-question-image" target="_blank"><img src="http://q.hatena.ne.jp/enquetegraph?qid=1142238823&amp;qnum=2&amp;h=140&amp;w=480" class="hatena-question-image"></a></p>

=== question:id:qN:image:small
--- skip
cannot fetch image
--- input
question:1142238823:q2:image:small
--- expected
<p><a href="http://q.hatena.ne.jp/1142238823#eq02" class="hatena-question-image" target="_blank"><img src="http://q.hatena.ne.jp/enquetegraph?qid=1142238823&amp;qnum=2&amp;h=140&amp;w=480" class="hatena-question-image"></a></p>
