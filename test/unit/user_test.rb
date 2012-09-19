require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "create user" do
    user = FactoryGirl.build(:user)
    assert user.save
    assert_equal user.email, "test_user@test.com"
    Rails.logger.debug "user.password_digest = #{user.password_digest}"
  end

  test "create user without email" do
    user = FactoryGirl.build(:user)
    user.email = nil
    assert !user.save
    Rails.logger.debug "user.errors = #{user.errors.each {|msg| p msg}}"
  end

  test "create user with wrong password confirmation" do
    user = FactoryGirl.build(:user)
    user.password_confirmation += "."
    assert !user.save
    Rails.logger.debug "user.errors = #{user.errors.each {|msg| p msg}}"
  end

end
