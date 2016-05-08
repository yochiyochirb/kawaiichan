class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(oauth_params[:provider])
  end

  def callback
    provider = oauth_params[:provider]
    if login_from(provider)
      redirect_to root_path, notice: 'Logged in with GitHub'
    else
      begin
        user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(user)
        redirect_to root_path, notice: 'Logged in with GitHub'
      rescue
        redirect_to root_path, alert: 'Failed to login with GitHub'
      end
    end
  end

  private

    def oauth_params
      params.permit(:provider)
    end
end
