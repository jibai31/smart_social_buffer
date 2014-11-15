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

  factory :content_with_messages, class: :content do
    url "some_url"

    # transient do
    #   messages_count 5
    # end

    after(:create) do |content, evaluator|
      # create_list(:message, evaluator.messages_count, content: content)
      create_list(:message, 5, content: content)
    end
  end

  factory :message do
    text "Some text"
    social_network "twitter"
    association :content
  end
end
