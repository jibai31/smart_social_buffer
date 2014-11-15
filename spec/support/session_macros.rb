module SessionMacros

  # === ARRANGE =========================================

  def create_user(email, options = {})
    provider = options[:provider] || 'google_oauth2'
    name = options[:name]

    create(:user_with_account, email: email, name: name, provider: provider)
  end

  # === ACT =============================================

  def visit_signup_page
    visit root_path
  end

  def visit_signin_page
    visit root_path
  end

  def sign_in_with_provider(provider)
    visit_signin_page
    click_link provider
  end

  # === ASSERT ==========================================

  def user_should_be_signed_in
    expect(page).to have_content('Sign out')
  end

  def user_should_be_signed_in_as name
    user_should_be_signed_in
    expect(page).to have_content(name)
  end

  def user_should_be_signed_out
    expect(page).to have_content("Log in")
  end

  def page_should_display_sign_in_error
    page.should have_css('div.error', 'Incorrect email or password')
  end

end
