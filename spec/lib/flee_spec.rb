require 'spec_helper'
require_relative '../../lib/flee_action.rb'

describe FleeAction do
	let(:hero) { double("hero", strength: 3, stealth: 3,
	 gain_exp: nil, gain_cold: nil, damage: nil) }
	let(:dicepool) { double("dicepool") }
	let(:action) { FleeAction.new hero, dicepool }
	let(:monster) { double("monster", toughness: 2, notice: 2, kill: nil,
		damage: 4) } 
	 
	describe "effect" do
	
	end

	describe "activate" do
		it "makes stealth check against target notice" do
			dicepool.should_receive(:skill_check).with(hero.stealth, monster.notice)
			action.activate(monster)
		end		
	end

	it 'respond to activate message' do
		expect(action).to respond_to(:activate)
	end
	
	it 'has an owner' do
		expect(action.owner).to eq(hero)
	end 
end 