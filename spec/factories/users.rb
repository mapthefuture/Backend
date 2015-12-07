FactoryGirl.define do
  factory :user do
    first_name        "John"
    last_name         "Doe"
    email             "name@email.com"
    avatar_file_name  "profile_picture.png"
  end
end