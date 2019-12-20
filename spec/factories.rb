FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com" 
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end

  factory :horse do
    name { "hello" }
    association :user
  end

  factory :item do
    title { "Order Hay" }
    done { false }
  end
end