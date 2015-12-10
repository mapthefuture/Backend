FactoryGirl.define do
  factory :site_review do
    association :reviewable, factory: :site
    tagline    "Great Tour"
    body       "Our favorite tour of the city."
    site
    user
  end

  factory :tour_review do
    association :reviewable, factory: :tour
    tagline    "Great Tour"
    body       "Our favorite tour of the city."
    tour
    user
  end
end
