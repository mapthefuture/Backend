FactoryGirl.define do
  factory :site_rating do
    association :rateable, factory: :site
    site
    score     5
    user
  end

  factory :tour_rating do
    association :rateable, factory: :tour
    tour
    score     5
    user
  end
end
