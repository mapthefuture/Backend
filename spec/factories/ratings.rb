FactoryGirl.define do
  factory :rating do
    rateable_id     3
    rateable_type   "Tour"
    score           5
    user_id         1    
  end
end
