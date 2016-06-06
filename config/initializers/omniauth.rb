Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack,
           ENV['SLACK_CLIENT_ID'],
           ENV['SLACK_CLIENT_SECRET'],
           scope: 'identify'

  on_failure { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }
end
