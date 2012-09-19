class ApplicationController < ActionController::Base

  after_filter :flash_to_headers

  #protect_from_forgery

  def flash_to_headers
    if !flash[:error].blank?
      response.headers['X-Message'] = flash[:error]
      response.headers['X-Message-Type'] = "error"
    elsif !flash[:notice].blank?
      response.headers['X-Message'] = flash[:notice]
      response.headers['X-Message-Type'] = "notice"
    elsif !flash[:success].blank?
      response.headers['X-Message'] = flash[:success]
      response.headers['X-Message-Type'] = "success"
    end
    flash.discard
  end

  private

  def current_user
    i = session[:user_id]
    Rails.logger.info "session.inspect = #{session.inspect}"
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      flash[:error] = "Not logged in"
      respond_with "Not logged in", :status => 401, :location => nil
    end
  end

end
