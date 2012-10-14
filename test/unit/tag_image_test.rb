require 'test_helper'

class TagImageTest < ActiveSupport::TestCase

  test "create image" do

    tag_image = FactoryGirl.build(:tag_image)

    Rails.logger.debug "image (before save) = #{tag_image}"
    Rails.logger.debug "image.file (before save) = #{tag_image.image}"
    Rails.logger.debug "image.file.url (before save) = #{tag_image.image.url}"
    Rails.logger.debug "image.file.store_dir (before save) = #{tag_image.image.store_dir}"

    assert tag_image.save

    Rails.logger.debug "image (aftersave) = #{tag_image}"
    Rails.logger.debug "image.file (after save) = #{tag_image.image}"
    Rails.logger.debug "image.file.url (after save) = #{tag_image.image.url}"
    Rails.logger.debug "image.file.store_dir (after save) = #{tag_image.image.store_dir}"

    assert_not_nil tag_image.image
    assert_not_nil tag_image.image.url
    assert_equal "forest.jpg", tag_image.image.identifier

    assert_not_nil tag_image.user

    assert_equal "test_user@test.com", tag_image.user.email

  end

end
