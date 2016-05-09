require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'body_html should return rendered html' do
    post = posts(:alice_in_wonderland)
    expected = <<-EOS
<h1 id="down-the-rabbit-hole">Down the Rabbit-Hole</h1>

<h2 id="beginning">Beginning</h2>

<p>Alice was beginning to get very tired of sitting by her sister on the bank,<br />
and of having nothing to do.</p>

<h2 id="considering">Considering</h2>

<ul>
  <li>so she was considering</li>
  <li>in her own mind</li>
</ul>
    EOS
    assert_equal(expected, post.body_html)
  end

  test 'fenced code block rendered as expected' do
    post = posts(:fenced_code_block)
    expected = <<-EOS
<div class="language-ruby highlighter-rouge"><pre class="highlight"><code><span class="k">def</span> <span class="nf">foo</span>
  <span class="nb">puts</span> <span class="s1">'foo'</span>
<span class="k">end</span>
</code></pre>
</div>
    EOS
    puts post.body_html
    assert_equal(expected, post.body_html)
  end
end
