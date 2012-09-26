class ApiKeysController < ApplicationController

  skip_before_filter :verify_api_key

  respond_to :json

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      user.ensure_api_key
      flash[:success] = "Logged in!"
    else
      flash[:error] = "Email or password is invalid"
    end
    respond_with user do |format|
      format.json { render :json => user.api_keys.first.to_json(:only => :access_token) }
    end
  end

end
