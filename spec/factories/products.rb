FactoryGirl.define do
  factory :product do
    title "Super Product Name"
    price "9.99"
    published false
    quantity 10
    user
  end
end
