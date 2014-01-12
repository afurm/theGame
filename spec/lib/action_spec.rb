require 'spec_helper'
require_relative '../../lib/action.rb'

class TestAction
  include Actionable
	def action_attributes
		@attribute = :strength
		@defficulty = :toughness
	end
end

describe Actionable do
  let(:hero) { double("hero", strength: 3,
   gain_exp: nil, gain_cold: nil, damage: nil) }
  let(:dicepool) { double("dicepool") }
  let(:action) { TestAction.new hero}
  let(:monster) { double("monster", toughness: 2, kill: nil,
    damage: 4) }

  it_behaves_like "actionable"
 end   