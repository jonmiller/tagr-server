require 'test_helper'

class TagImageTest < ActiveSupport::TestCase

  setup do
    init_carrierwave_for_tests
  end

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
    assert_equal tag_image.image.identifier, "forest.jpg"
  end

end
