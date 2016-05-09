require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:alice_in_wonderland)
    @user = users(:alice)
  end

  test 'should get index' do
    PostsController.stub_any_instance(:current_user, @user) do
      get posts_url
      assert_response :success
    end
  end

  test 'should get new' do
    PostsController.stub_any_instance(:current_user, @user) do
      get new_post_url
      assert_response :success
    end
  end

  test 'should create post' do
    PostsController.stub_any_instance(:current_user, @user) do
      assert_difference('Post.count') do
        post posts_url, params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
      end
      assert_equal @user, Post.last.user
      assert_redirected_to post_path(Post.last)
    end
  end

  test 'should show post' do
    PostsController.stub_any_instance(:current_user, @user) do
      get post_url(@post)
      assert_response :success
    end
  end

  test 'should get edit' do
    PostsController.stub_any_instance(:current_user, @user) do
      get edit_post_url(@post)
      assert_response :success
    end
  end

  test 'should update post' do
    PostsController.stub_any_instance(:current_user, @user) do
      patch post_url(@post), params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
      assert_redirected_to post_path(@post)
    end
  end

  test 'should destroy post' do
    PostsController.stub_any_instance(:current_user, @user) do
      assert_difference('Post.count', -1) do
        delete post_url(@post)
      end
    end
    assert_redirected_to posts_path
  end
end
