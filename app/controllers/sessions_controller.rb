class SessionsController < ApplicationController
  def destroy
    logout
    redirect_to root_url, notice: 'Successfully logged out.'
  end
end
