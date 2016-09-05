ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails/capybara"
require "webmock/minitest"
require "capybara/poltergeist"
require "minitest/around"
require "database_cleaner"

Capybara.javascript_driver = :poltergeist
Capybara.server = :puma

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
end

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Stub Slack OAuth login with OmniAuth mock
  def stub_slack_login_with(nickname)
    user = User.find_by!(nickname: nickname)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new(
      provider: "slack",
      uid: user.uid,
      info: {
        nickname: user.nickname
      }
    )
  end

  # Stub whole authentication includes:
  # - Slack OAuth login
  # - Visiting login page
  # - Team checking
  def stub_authentication_with(nickname)
    stub_slack_login_with(nickname)

    visit login_path

    VCR.use_cassette "slack/users_info" do
      click_link "Login with Slack"
    end
  end
end

class Capybara::Rails::TestCase
  around do |test|
    if metadata[:js]
      page.driver.clear_memory_cache
      DatabaseCleaner.cleaning(&test)
    else
      test.call
    end
  end

  # Wait a sec because tests will fail if a channel is not subscribed yet
  def wait_action_cable_subscription
    sleep 1
  end
end
