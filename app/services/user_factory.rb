class UserFactory

  def initialize(auth, user = nil)
    @auth = auth
    @user = user || User.new
  end

  def build
    @user.name = @auth['info']['name']    unless @user.name.present?
    @user.email = @auth['info']['email']  unless @user.email.present?
    @user.language = language_code        unless @user.language.present?
    @user.avatar = @auth['info']['image'] unless @user.avatar.present?

    @user.add_provider(@auth)

    @user
  end

  private

  def language_code
    if @auth['extra'] && @auth['extra']['raw_info'] && @auth['extra']['raw_info']['locale']
      @auth['extra']['raw_info']['locale']
    else
      'en'
    end
  end
end
