require 'test_helper'

feature 'login with slack' do
  scenario 'must have login link' do
    visit login_path

    within '.login__login-link' do
      page.must_have_content 'Login with Slack'
    end
  end

  scenario 'can login with slack' do
    stub_slack_login_with 'alice'

    visit login_path
    click_link 'Login with Slack'

    within '.flash-message__notice' do
      page.must_have_content 'Logged in with Slack'
    end

    within '.navigation__list' do
      page.must_have_content 'Logout'
    end
  end
end
