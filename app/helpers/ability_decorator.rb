class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    can :read, Spree::ColorType
    can :index, Spree::ColorType
    can :read, Spree::ColorValue
    can :index, Spree::ColorValue
  end
end

Spree::Ability.register_ability(AbilityDecorator)