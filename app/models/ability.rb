class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.owner?
      can :manage, :all
    elsif user.manager?

    elsif user.operator?

    end
  end
end
