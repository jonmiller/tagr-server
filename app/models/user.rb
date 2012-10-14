class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :api_keys, :dependent => :destroy
  has_and_belongs_to_many :tag_images

  def ensure_api_key
    if api_keys.empty?
      reset_api_keys
    end
  end

  def reset_api_keys
    api_keys.delete_all
    api_keys << ApiKey.create
  end

end
