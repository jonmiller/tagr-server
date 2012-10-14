require 'test_helper'

class ApiKeysControllerTest < ActionController::TestCase

  setup do
    @user = FactoryGirl.create(:user)
    @user_attrs = FactoryGirl.attributes_for(:user)
  end

  test "login" do
    @user_attrs[:format] = "json"
    post :create, @user_attrs
    assert_response :success, "Logged in!"
    api_key = JSON.parse(@response.body)
    Rails.logger.debug "api_key = #{api_key}"
    Rails.logger.debug "api_key.access_token = #{api_key['access_token']}"
    assert_not_nil api_key["access_token"]
    assert !api_key["access_token"].blank?
  end

end
