FactoryGirl.define do

  factory :user do
    email "test_user@test.com"
    password "testpassword"
    password_confirmation "testpassword"
  end

  factory :user_with_tag_images, class: User do
    email "test_user_ti@test.com"
    password "testpassword"
    password_confirmation "testpassword"
    tag_images { 
      2.times.map do
        FactoryGirl.create(:tag_image) 
      end
    }
  end

  factory :user_2, class: User do
    email "test_user2@test.com"
    password "testpassword"
    password_confirmation "testpassword"
  end

  factory :user_2_with_tag_images, class: User do
    email "test_user_2_ti@test.com"
    password "testpassword"
    password_confirmation "testpassword"
    tag_images {
      2.times.map do 
        FactoryGirl.create(:tag_image_flatirons)
      end
    }
  end

end

