class ApplicationController < ActionController::Base

  before_filter :verify_api_key
  after_filter :flash_to_headers

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
    access_token = params[:api_key]
    return nil unless !access_token.nil?
    api_key = ApiKey.find_by_access_token(access_token) 
    return nil unless !api_key.nil? 
    @current_user ||= User.find(api_key.user_id)
  end
  helper_method :current_user

  def verify_api_key
    head :unauthorized if current_user.nil?
  end

end
