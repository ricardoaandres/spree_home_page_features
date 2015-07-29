include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :banner_category, class: Spree::BannerCategory do
    name 'A category name'
    size '1x1'
  end

  factory :invalid_banner_category, class: Spree::BannerCategory do
    name nil
  end

  factory :banner, class: Spree::Banner do
    title 'A title'
    body 'A body'
    url 'http://acid.cl'

    trait :with_image do
      body ''
      image { fixture_file_upload('spec/fixtures/test_img.jpg', 'image/jpg') }
    end

    trait :with_product_and_taxon do
      url nil
      product
      taxon
    end
  end

  factory :invalid_banner, class: Spree::Banner do
    title nil
  end
end
