# encoding: UTF-8
class AccountsController < Devise::OmniauthCallbacksController
  load_and_authorize_resource only: [:index, :destroy]
  layout "settings", only: [:index]

  def index
  end

  def destroy
    if @account
      @account.destroy!
    end
    redirect_to accounts_path
  end

  # Omniauth callbacks

  def google_oauth2
    try_sign_in_user
  end

  def facebook
    try_sign_in_user
  end

  def twitter
    try_sign_in_user
  end

  def linkedin
    try_sign_in_user
  end

  private

  def try_sign_in_user
    logger.debug auth.to_yaml
    account = Account.find_by_provider_and_uid(auth.provider, auth.uid)
    user = current_user || User.find_by_email(auth.info.email)

    if account
      logger.info "The user has already authenticated with this provider"
      sign_in_and_redirect account.user

    elsif user
      logger.info "The user is currently signed in, but with another provider"
      user.add_provider!(auth)
      sign_in_and_redirect user

    else
      logger.info "No authenticated user, and unknown provider"
      user = UserFactory.new(auth).build

      if user.save
        sign_in_and_redirect user

      else
        logger.info "User validation failed"
        logger.info "Most likely the oauth info did not contain any email (eg, Twitter account)"
        logger.info user.errors.messages

        session['devise.omniauth'] = auth

        flash.notice = "C'est presque bon ! Entrez un email pour finir votre enregistrement."
        redirect_to new_user_registration_path
      end
    end
  end

  def auth
    request.env["omniauth.auth"]
  end
end
