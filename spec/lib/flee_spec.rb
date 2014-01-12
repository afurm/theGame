require 'spec_helper'
require_relative '../../lib/flee_action.rb'

describe FleeAction do
  let(:hero) { double("hero", strength: 3, stealth: 3,
   gain_exp: nil, gain_cold: nil, damage: nil) }
  let(:dicepool) { double("dicepool") }
  let(:action) { FleeAction.new hero }
  let(:monster) { double("monster", toughness: 2, notice: 2, kill: nil,
    damage: 4) } 
   
  it_behaves_like "actionable"
  
  describe "effect" do
    before :each do
      Dicepool.stub(:new).and_return(dicepool)
    end
    context "success" do
      it "sends flee message to the owner" do
        dicepool.stub(:skill_check).and_return(true)
        hero.should_receive(:flee)
        action.activate(monster)
      end
    end

    context "failure" do
      it "deals damage to the owner" do
        dicepool.stub(:skill_check).and_return(false)
        hero.should_receive(:damage).with(monster.damage)
        action.activate(monster)
      end
    end
  end

  describe "activate" do
    before :each do
      Dicepool.stub(:new).and_return(dicepool)
    end
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