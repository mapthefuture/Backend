FactoryGirl.define do
  factory :tour do
    title        "Walking Tour of Atlanta"
    description  "A full tour of the city"
    length     5.5
    duration     50000
    start_lat    12.121212
    start_lon    34.343434
    category     "Historical"
    user

    factory :tour_with_sites do
      transient do
        site_count 5
      end
      after(:create) do |tour, evaluator|
        create_list(:site, evaluator.site_count, tour: tour)
      end
    end

    factory :tour_with_ratings do
      transient do
        tour_rating_count 5
      end
      after(:create) do |tour, evaluator|
        create_list(:rating, evaluator.tour_rating_count, tour: tour)
      end
    end

    factory :tour_with_tour_reviews do
      transient do
        tour_review_count 5
      end
      after(:create) do |tour, evaluator|
        create_list(:tour_review, evaluator.tour_review_count, tour: tour)
      end
    end

    factory :tour_with_favorites do
      transient do
        favorite_count 5
      end
      after(:create) do |tour, evaluator|
        create_list(:favorite, evaluator.favorite_count, tour: tour)
      end
    end

    factory :tour_rating do
      after(:create) do |tour|
        create(:rating, rateable: tour)
      end
    end
  end
end
