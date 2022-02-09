FactoryBot.define do
  require "faker"
  factory :user do
    username{ Faker::Internet.username }
    email{ Faker::Internet.email(name: username)}
    after(:build){ |u| u.password_confirmation = u.password = "98923442"}
    factory :followed, class: "User" do 
      :follow
      :follower
    end
    factory :follower, class: "User" do 
      :follow
      :followed
    end
    factory :user_with_lists_with_books do 
      after(:create) do |user|
        create_list(:list_with_books, 5, user_id: user.id)
      end
    end
  end

  factory :list do 
    name{Faker::App.name}
    :user
    factory :list_with_books do
      after(:create){create_list(:book, 5)}
    end

    factory :list_with_user_and_books do 
      after(:create){create_list(:book, 5)}
    end
  end

  factory :follow do 
    :followed
    :follower
  end

  factory :author do
    name{ Faker::Internet.username }
  end

  factory :book do
    title{ Faker::Book.title }
    series{ Faker::Book.publisher }
    sequence(:lb_id){ |n| n}
    sequence(:isbn){ |n| "ISBN#{n}" }

    factory :book_with_reviews do 
      after(:create) do |book|
        user = create(:user)
        create_list(:review, 10, book_id: book.id, user_id: user.id)
        #book.reload
      end
    end

    factory :book_with_author do
      after(:create) do |book|
        book.authors << create(:author)
      end
    end

    factory :book_with_test_author do
      after(:create) do |book|
        book.authors << create(:author, name: "Test Author")
      end
    end
  end

  factory :review do
    sequence(:body){ |n| "fish text #{n} some random text there here" }
    rating{ rand(1..5) }
    user{ create(:user) }
    book{ create(:book) }
    :book
    :user
  end

  factory :author_book do 
    :author
    :book
  end
end


