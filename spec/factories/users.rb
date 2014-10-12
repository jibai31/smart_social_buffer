FactoryGirl.define do
  factory :user do
    email     "john.doe@example.com"
    name      "John Doe"
    password  "password"

    factory :user_with_authentication do
      ignore do
        provider "twitter"
      end
      after(:create) do |user, evaluator|
        FactoryGirl.create(:authentication, user: user, provider: evaluator.provider)
      end
    end
  end

  factory :authentication do
    provider "provider"
    uid "12345"
    user
  end

end
