FactoryGirl.define do

  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    first_name        "John"
    last_name         "Doe"
    avatar_file_name  "profile_picture.png"
    password          "password"
    email

    factory :user_with_tours do
      transient do
        tour_count 5
      end
      after(:create) do |user, evaluator|
        create_list(:tour, evaluator.tour_count, user: user)
      end
    end
  end
end
