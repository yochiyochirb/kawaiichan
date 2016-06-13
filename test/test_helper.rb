ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Stub Slack OAuth login with OmniAuth mock
  def stub_slack_login_with(nickname)
    user = User.find_by!(nickname: nickname)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new(
      provider: 'slack',
      uid: user.uid,
      info: {
        nickname: user.nickname
      }
    )
  end
end
