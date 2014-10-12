class UserFactory

  def initialize(auth)
    @auth = auth
  end

  def build
    user = User.new

    user.name = @auth.info.name
    user.email = @auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.language = @auth.extra.raw_info.locale
    user.avatar = @auth.info.image

    user.add_provider(@auth)

    user
  end
end
