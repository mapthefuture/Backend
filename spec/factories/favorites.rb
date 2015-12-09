FactoryGirl.define do
  factory :tour_favorite do
    association :favoritable, factory: :tour

    user             
    tour
  end

## Use association below once individual sites can also be favorited

  # factory :site_favorite do
  #   association :favoritable, factory: :site

  #   user             
  #   site
  # end
end
