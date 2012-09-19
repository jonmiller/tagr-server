class TagImage < ActiveRecord::Base
  attr_accessible :image
  mount_uploader :image, TagImageUploader
end
