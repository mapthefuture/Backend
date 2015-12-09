FactoryGirl.define do
  factory :tour do
    title        "Walking Tour of Atlanta"
    description  "A full tour of the city"
    distance     5.5
    duration     50000
    start_lat    12.121212
    start_lon    34.343434
    category     "Historical"
    user_id      4
  end
end
