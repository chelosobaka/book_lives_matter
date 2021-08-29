FactoryBot.define do
  require "faker"
  factory :user do
    #username_variable = Faker::Internet.username
    username{ Faker::Internet.username }
    email{ Faker::Internet.email(name: username)}
    after(:build){ |u| u.password_confirmation = u.password = "98923442"}
    association :review1
    association :book
  end

  factory :book do
    title{ Faker::Book.title }
    series{ Faker::Book.publisher }
    sequence(:lb_id){ |n| n}
    sequence(:isbn){ |n| "ISBN#{n}" }
    association :review1
    factory :book_with_review do 
      after(:build) do |book|
    end
  end
  factory :review do
    sequence(:text){ |n| "fish text #{n}" }
    rating{ rand(1..5) }
    association :user
    association :book
    
  end
end


