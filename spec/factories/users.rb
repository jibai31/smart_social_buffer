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
    after(:create) do |account|
      create(:planning, account: account)
    end
  end

  factory :content_with_one_message, class: :content do
    url "some_url"

    after(:create) do |content, evaluator|
      create_list(:message, 1, content: content)
    end
  end

  factory :content_with_two_messages, class: :content do
    url "some_url"

    after(:create) do |content, evaluator|
      create_list(:message, 2, content: content)
    end
  end

  factory :content_with_messages, class: :content do
    url "some_url"

    after(:create) do |content, evaluator|
      create_list(:message, 5, content: content)
    end
  end

  factory :message do
    text "Some text"
    social_network "twitter"
    association :content
  end

  factory :planning do
    account
  end
end
