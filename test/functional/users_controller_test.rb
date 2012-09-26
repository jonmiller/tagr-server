require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "create new user" do
    user = FactoryGirl.attributes_for(:user)
    post :create, {:user => user, :format => "json"}
    assert_response :success, "User created"
    assert_equal "User created", response.headers['X-Message']
  end
  
end
