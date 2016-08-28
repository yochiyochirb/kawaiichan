require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'should not be valid without title' do
    post = Post.new
    post.body = 'Alice was beginning to get ...'
    refute post.valid?
  end

  test 'should set updater same as creator before validation on create' do
    post = Post.new
    post.title = 'Alice In Wonderland'
    post.body = 'Alice was beginning to get ...'
    post.created_by_id = users(:alice).id
    post.valid?
    assert_equal users(:alice).id, post.updated_by_id
  end
end
