require_relative 'action.rb'

class AttackAction < Action

  def action_attributes
    @attribute = :strength
    @difficulty = :toughness
  end
  
  def success(target)
    target.kill
    owner.gain_exp
    owner.gain_cold
  end

  def failure(target)
    owner.damage(target.damage)
  end
end