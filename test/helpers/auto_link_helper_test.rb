require 'test_helper'

class AutoLinkHelperTest < ActionView::TestCase
  include AutoLinkHelper

  test 'should auto link only urls' do
    assert_equal 'Hello <a href="http://example.com">http://example.com</a> mailto://test@example.com',
                 auto_link('Hello http://example.com mailto://test@example.com')
  end

  test 'should not link a tag links' do
    assert_equal '<a href="http://example.com">http://example.com</a>',
                 auto_link('<a href="http://example.com">http://example.com</a>')
  end

  test 'should not link in pre tags' do
    assert_equal '<div><a href="http://example.com">http://example.com</a></div> <pre>http://example.com</pre>',
                 auto_link('<div>http://example.com</div> <pre>http://example.com</pre>')
  end

  test 'should not link in code tags' do
    assert_equal '<code>http://example.com</code>',
                 auto_link('<code>http://example.com</code>')
  end
end
