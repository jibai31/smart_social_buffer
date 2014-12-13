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

  factory :content do
    url "some_url"
    category_id 1

    factory :content_with_messages do
      ignore do
        number_of_messages 5
      end
      after(:create) do |content, evaluator|
        create_list(:message, evaluator.number_of_messages, content: content)
      end
    end

    factory :content_with_posted_messages do
      ignore do
        number_of_messages 5
      end
      after(:create) do |content, evaluator|
        create_list(:posted_message, evaluator.number_of_messages, content: content)
      end
    end
  end

  factory :message do
    text "Some text"
    social_network "twitter"
    association :content

    factory :posted_message do
      sequence(:posts_count)
    end
  end

  factory :planning do
    account
  end
end
