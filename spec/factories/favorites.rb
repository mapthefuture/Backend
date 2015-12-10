FactoryGirl.define do
  factory :favorite do
    association :favoritable, factory: :tour
    user
  end
end
