require 'action'

class WandOfFire
include Actionable

  def action_attributes
    @attribute = :strength
    @difficulty = :toughtness
  end 
end
