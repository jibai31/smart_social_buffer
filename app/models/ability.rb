class Ability
  include CanCan::Ability

  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # CREATE
    can :create, [Blog, Content, Message]

    # READ
    can :read, [Blog, Content, Authentication], user_id: user.id

    # UPDATE
    can :update, [Blog, Content], user_id: user.id

    # DESTROY
    can :destroy, [Blog, Content], user_id: user.id
  end
end
