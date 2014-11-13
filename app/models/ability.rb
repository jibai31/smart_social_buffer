# encoding: UTF-8
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
    can :update, Content, user_id: user.id
    can [:update, :import], Blog, user_id: user.id

    # DESTROY
    can :destroy, [Blog, Content, Authentication], user_id: user.id
  end
end
