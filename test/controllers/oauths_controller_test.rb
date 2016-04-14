require 'test_helper'

class OauthsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alice = users(:alice)
  end

  test 'should login successfully with existing user' do
    OauthsController.stub_any_instance(:login_from, @alice) do
      get oauth_callback_url(provider: 'github')
      assert_redirected_to root_url
      assert_equal 'Logged in with GitHub', flash[:notice]
    end
  end

  test 'should create user with new user' do
    OauthsController.stub_any_instance(:login_from, nil) do
      OauthsController.stub_any_instance(:create_from, @alice) do
        get oauth_callback_url
        assert_redirected_to root_url
        assert_equal 'Logged in with GitHub', flash[:notice]
      end
    end
  end

  test 'should fail with invalid user' do
    OauthsController.stub_any_instance(:login_from, nil) do
      OauthsController.stub_any_instance(:create_from, -> { raise }) do
        get oauth_callback_url
        assert_redirected_to root_url
        assert_equal 'Failed to login with GitHub', flash[:alert]
      end
    end
  end
end
