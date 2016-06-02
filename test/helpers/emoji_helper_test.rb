require 'test_helper'

class EmojiHelperTest < ActionView::TestCase
  include EmojiHelper
  include ERB::Util # because html_escape is used in the helper

  test 'should convert emoji alias' do
    assert_equal 'Hello <img alt="new_moon_with_face" src="/images/emoji/unicode/1f31a.png" style="vertical-align:middle" width="20" height="20" />, good-bye <img alt="sun_with_face" src="/images/emoji/unicode/1f31e.png" style="vertical-align:middle" width="20" height="20" />',
                 emojify('Hello :new_moon_with_face:, good-bye :sun_with_face:')
  end

  test 'should return blank string if content is blank' do
    assert_equal('', emojify(''))
    assert_equal('', emojify(nil))
  end
end
