FactoryGirl.define do

  factory :tag_image do
    image { File.open("#{Rails.root}/test/fixtures/files/forest.jpg") }
  end

  factory :tag_image_base64, class: TagImage do
    image { Base64.encode64(File.open("#{Rails.root}/test/fixtures/files/forest.jpg").to_a.join) }
    filename "forest.jpg"
  end

  factory :tag_image_flatirons, class: TagImage do
    image { File.open("#{Rails.root}/test/fixtures/files/flatirons.jpg") }
  end

  factory :tag_image_flatirons_base64, class: TagImage do
    image { Base64.encode64(File.open("#{Rails.root}/test/fixtures/files/flatirons.jpg").to_a.join) }
    filename "flatirons.jpg"
  end

end

