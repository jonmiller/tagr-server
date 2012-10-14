class CreateTagImagesUsersTable < ActiveRecord::Migration
  def up
    create_table :tag_images_users, id: false do |t|
      t.references :user
      t.references :tag_image
    end
    add_index :tag_images_users, [:user_id, :tag_image_id]
    add_index :tag_images_users, [:tag_image_id, :user_id]
  end

  def down
    drop_table :users_tag_images
  end
end
