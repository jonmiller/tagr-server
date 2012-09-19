class SessionsController < ApplicationController

  respond_to :json

  def create
    Rails.logger.info "CSRF Token: #{request.headers['X-CSRF-Token']}"
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in!"
    else
      flash[:error] = "Email or password is invalid"
    end
    respond_with user, :location => nil
  end

  def destroy
    session[:user_id] = nil
    flash.success "Logged out!"
  end

end
