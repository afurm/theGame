require 'spec_helper'
require_relative '../../lib/attack_action.rb'

describe AttackAction do
  let(:hero) { double("hero", strength: 3,
   gain_exp: nil, gain_gold: nil, damage: nil) }
  let(:dicepool) { double("dicepool") }
  let(:action) { AttackAction.new hero}
  let(:monster) { double("monster", toughness: 2, kill: nil,
    damage: 4, exp: 10, gold: 20) }

  it_behaves_like "actionable"   
   
  describe "effect" do
    before :each do
      Dicepool.stub(:new).and_return(dicepool)
    end
    context "success" do
      before :each do
        dicepool.stub(:skill_check).and_return(true)
      end
      it "kills monster" do
        monster.should_receive(:kill)
        action.activate(monster)
      end
      
      it "rewards owner with experience" do
        hero.should_receive(:gain_exp)
        action.activate(monster)
      end
      
      it "rewards owner with cold" do
        hero.should_receive(:gain_gold)
        action.activate(monster)
      end
    end
    
    context "failure" do
      it "damage owner" do
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
    it "makes strength check against target toughness" do
      dicepool.should_receive(:skill_check).with(hero.strength, monster.toughness)
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