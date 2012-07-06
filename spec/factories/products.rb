FactoryGirl.define do
  sequence :name do |n|
    "product#{n}"
  end

  sequence :description do |n|
    "This is description #{n}"
  end

  factory :product do
    name
    description
    business
    catalog
  end
end
