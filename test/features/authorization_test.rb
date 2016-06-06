require 'test_helper'

feature 'authorization' do
  scenario 'can access posts page when logging in' do
    stub_github_login_with 'alice'

    visit login_path
    click_link 'Login with GitHub'

    visit posts_path

    within '.login-screen__login-link' do
      page.must_have_content 'Login with GitHub'
    end
  end

  scenario 'cannot access posts page without logging in' do
    visit posts_path

    within '.flash-message__alert' do
      page.must_have_content 'Please login'
    end

    within '.login-screen__login-link' do
      page.must_have_content 'Login with GitHub'
    end
  end
end

