require_relative 'dicepool'
module Actionable
  attr_reader :owner, :dicepool, :attribute, :difficulty

  def initialize(owner = nil)
    @owner = owner 
    @dicepool = Dicepool.new

    action_attributes
  end

  def action_attributes
    raise "You must initialize @attribute and @difficulty"
  end

  def activate(target)
    if dicepool.skill_check(owner.send(attribute),
     target.send(difficulty))
      success(target) 
    else
      failure(target)
    end 
  end

  def asign_owner(owner)
    @owner = owner
  end

  def success
  end
  
  def failure
  end
end 