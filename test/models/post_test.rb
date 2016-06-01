require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'should not be valid without title' do
    post = Post.new
    post.body = 'Alice was beginning to get ...'
    refute post.valid?
  end
end
