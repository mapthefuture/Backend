FactoryGirl.define do
  factory :rating do
    association :rateable, factory: :tour
    score     5
    user
  end
end
