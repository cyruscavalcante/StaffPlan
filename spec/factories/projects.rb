FactoryGirl.define do
  factory :project do
    name    { Faker::Company.bs }
    client
  end
end
