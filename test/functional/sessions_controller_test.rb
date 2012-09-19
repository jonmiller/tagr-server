require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @user_attrs = FactoryGirl.attributes_for(:user)
    @user = FactoryGirl.create(:user)
  end

  test "login" do
    @user_attrs[:format] = "json"
    post :create, @user_attrs
    assert_response :success, "Logged in!"
    assert_equal @user.id, session[:user_id] 
  end

  #test "should get destroy" do
  #  get :destroy
  #  assert_response :success
  #end

end
