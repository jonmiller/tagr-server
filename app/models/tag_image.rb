class TagImage < ActiveRecord::Base

  attr_accessible :image

  has_and_belongs_to_many :users

  mount_uploader :image, TagImageUploader

end
