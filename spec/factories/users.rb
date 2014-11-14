FactoryGirl.define do
  factory :user do
    email     "john.doe@example.com"
    name      "John Doe"
    password  "password"

    factory :user_with_account do
      ignore do
        provider "twitter"
      end
      after(:create) do |user, evaluator|
        FactoryGirl.create(:account, user: user, provider: evaluator.provider)
      end
    end
  end

  factory :account do
    provider "provider"
    uid "12345"
    user
  end

end
