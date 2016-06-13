require 'test_helper'

feature 'Authentication' do
  scenario 'Can access posts page when logging in' do
    stub_slack_login_with 'alice'

    visit login_path

    VCR.use_cassette 'slack/users_info' do
      click_link 'Login with Slack'
    end

    visit posts_path

    within '.card-title', match: :first do
      page.must_have_content posts(:alice_in_wonderland).title
    end
  end

  scenario 'Cannot access posts page without logging in' do
    visit posts_path

    within '.flash-message__alert' do
      page.must_have_content 'Please login'
    end

    within '.login__login-link' do
      page.must_have_content 'Login with Slack'
    end
  end
end
