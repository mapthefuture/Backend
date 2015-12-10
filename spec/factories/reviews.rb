FactoryGirl.define do
  factory :review do
    tagline    "Great Tour"
    body       "Our favorite tour of the city."
    tour
    user
  end
end
