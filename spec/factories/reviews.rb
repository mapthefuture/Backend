FactoryGirl.define do
  factory :review do
    tagline    "Great Tour"
    body       "Our favorite tour of the city."
    user_id    12
    tour_id    13
  end
end
