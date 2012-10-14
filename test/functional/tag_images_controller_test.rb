require 'test_helper'

class TagImagesControllerTest < ActionController::TestCase

  setup do
    @tag_image = FactoryGirl.create(:tag_image)
    @tag_image_base64_attrs = FactoryGirl.attributes_for(:tag_image_base64)
    @tag_image_flatirons_base64_attrs = FactoryGirl.attributes_for(:tag_image_flatirons_base64)
    @user = FactoryGirl.create(:user_with_tag_images)
    @user_2 = FactoryGirl.create(:user_2_with_tag_images)
    @user.ensure_api_key
    @api_key = @user.api_keys.first.access_token
    @user_2.ensure_api_key
    @api_key_2 = @user_2.api_keys.first.access_token
  end

  test "index" do
    get :index, {format: "json", api_key: @api_key} 
    assert_response :success
    assert_not_nil assigns(:tag_images)
    Rails.logger.debug "response.body = #{@response.body}"
  end

  test "index for user 1" do 
    Rails.logger.debug "@api_key = #{@api_key}"
    get :index, {format: "json", api_key: @api_key}
    tag_images = JSON.parse(@response.body)
    assert_equal 2, tag_images.length
    assert tag_images.first["image"]["url"].ends_with? "forest.jpg"
  end

  test "index for user 2" do 
    Rails.logger.debug "@api_key_2 = #{@api_key_2}"
    get :index, {format: "json", api_key: @api_key_2}
    tag_images = JSON.parse(@response.body)
    assert_equal 2, tag_images.length
    assert tag_images.first["image"]["url"].ends_with? "flatirons.jpg"
  end

  test "show" do
    get :show, {id: @tag_image.id, format: "json", api_key: @api_key} 
    assert_response :success
    Rails.logger.debug "response.body = #{@response.body}"
  end

  test "should create tag_image" do
    assert_difference("TagImage.count") do
      post :create, 
        { 
          tag_image: @tag_image_base64_attrs, 
          format: "json", 
          api_key: @api_key
        }   
    end
    assert_response :success
    Rails.logger.debug "response.body = #{@response.body}"
  end

  test "should update tag_image" do
    put :update, 
      { 
        id: @tag_image.id,
        tag_image: @tag_image_flatirons_base64_attrs, 
        format: "json",
        api_key: @api_key
      }
    assert_not_nil assigns(:tag_image)
    Rails.logger.debug "response.body = #{@response.body}"
  end

  test "should destroy tag_image" do
    assert_difference('TagImage.count', -1) do
      delete :destroy, { id: @tag_image.id, format: "json", api_key: @api_key }
    end
  end

end
