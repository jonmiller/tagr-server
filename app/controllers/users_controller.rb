class UsersController < ApplicationController

  skip_before_filter :verify_api_key

  respond_to :json

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User created"
    else
      flash[:error] = "User creation failed"
    end
    respond_with @user, :location => nil
  end

end
