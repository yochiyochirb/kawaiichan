require 'test_helper'

feature 'login with GitHub' do
  scenario 'must have login link' do
    visit login_path

    within '.login-screen__login-link' do
      page.must_have_content 'Login with GitHub'
    end
  end

  scenario 'can login with Github' do
    stub_github_login_with 'alice'

    visit login_path
    click_link 'Login with GitHub'

    within '.flash-message__notice' do
      page.must_have_content 'Logged in with Github'
    end

    within '.navigation__list' do
      page.must_have_content 'Logout'
    end
  end
end
