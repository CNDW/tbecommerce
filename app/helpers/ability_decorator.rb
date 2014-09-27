class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    can :display, Spree::ColorType
    can :display, Spree::ColorValue
  end
end

Spree::Ability.register_ability(AbilityDecorator)