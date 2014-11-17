require 'rails_helper'

feature 'Visitor signs in' do

  scenario 'with a provider already registered' do
    create_user 'john.doe@example.com', provider: 'google_oauth2', name: 'John Google'

    sign_in_with_provider "Google"
    user_should_be_signed_in_as "John Google"
  end

  scenario 'with a new provider' do
    create_user 'john.doe@example.com', provider: 'facebook', name: 'John Facebook'

    sign_in_with_provider "Google"
    user_should_be_signed_in_as "John Facebook"
  end

  scenario 'with a new provider missing the email' do
    sign_in_with_provider "Twitter"

    fill_in :user_email, with: "john.smith@example.com"
    click_button "Sign up"

    user_should_be_signed_in_as "John Doe"
  end

  scenario 'for the first time' do
    sign_in_with_provider "Google"

    user_should_be_signed_in_as "John Doe"
  end
end
