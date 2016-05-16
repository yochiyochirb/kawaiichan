Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           Rails.application.secrets.github['key'],
           Rails.application.secrets.github['secret']

  on_failure { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }
end
