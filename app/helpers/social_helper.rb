module SocialHelper

  # Signin buttons

  def google_signin_button
    signin_button(:google_oauth2)
  end

  def facebook_signin_button
    signin_button(:facebook, path_options: facebook_signin_path_options)
  end

  def facebook_signin_path_options
    {display: "popup"}
  end

  def twitter_signin_button
    signin_button(:twitter)
  end

  def linkedin_signin_button
    signin_button(:linkedin)
  end

  def signin_button(provider, options = {})
    provider_name = provider_friendly_name(provider)
    path_options = options[:path_options] || {}

    link_to provider_name.capitalize,
      user_omniauth_authorize_path(provider, path_options),
      class: "social-img",
      id: "#{provider_name}Signin"
  end

  def provider_friendly_name(provider)
    provider.to_s.split('_').first
  end

end
