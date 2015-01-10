# encoding: UTF-8
class Ability
  include CanCan::Ability

  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  def initialize(user)

    # Prevent access to guests
    return unless user

    # CREATE
    can :create, Content
    can :create, Message if user.accounts.implemented.count > 0
    can [:create, :autoimport], Blog
    can [:create, :fill], BufferedPost

    # READ
    can :read, [Blog, Content, Account, BufferedPost], user_id: user.id
    can :manage, Message, content: {user_id: user.id}
    can :read, Planning, account: {user_id: user.id}

    # UPDATE
    can :update, Content, user_id: user.id
    can [:update, :import], Blog, user_id: user.id

    # DESTROY
    can :destroy, [Blog, Content, Account, BufferedPost], user_id: user.id
  end
end
