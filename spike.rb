require 'io/console'
require_relative 'lib/action.rb'
require_relative 'lib/attack_action.rb'
require_relative 'lib/dicepool.rb'
require_relative 'lib/flee_action.rb'
require_relative 'lib/hero.rb'
require_relative 'lib/monster.rb'

hero = Hero.new(strenght: 5, stealth: 5, health: 15,  actions: { attack: AttackAction.new, flee: FleeAction.new })  

kills = 0
flees = 0

5.times do |number|
  toughness = 1 + rand(3)
  notice = 1 + rand(2)
  damage = 1 + rand(4)
  mult = 1 + rand(3)

  monster =  Monster.new toughness: toughness, notice: notice, damage: damage, exp: toughness * mult, gold: damage * mult

  puts "\n\n\n"
  puts "=================================="
  puts "You're fighting MONSTER #{number + 1 } with:"
  puts "\t toughness: #{monster.toughness}"
  puts "\t notice: #{monster.notice}"
  puts "\t What do you do? (a) for attack, (f) for flee"
  puts "==================================="

  battle_is_over = false

  until battle_is_over
    if STDIN.getch == 'a'
      hero.activate_action :attack, monster
      if monster.dead?
        puts "You Won"
        puts "You gained #{monster.exp} experience"
        puts "You gained #{monster.gold} gold"
        puts "============================"
        battle_is_over = true
        kills+=1
      else
        puts "You Missed"
        puts "Monster deal #{monster.damage} to you"
        puts "You are current health is #{hero.health}"
        battle_is_over = true if hero.dead?
      end
    else
      hero.activate_action :flee, monster
      if hero.fled?
        puts "You Coward"
        puts "============================="
        battle_is_over = true
        flees += 1
      else
        puts "You could not flee"
        puts "Monster deal #{monster.damage} to you"
        puts "You are current health is #{hero.health}"
        puts "============================="
        battle_is_over = true if hero.dead?
      end
    end
  end

  break if hero.dead?
  hero.reset_flee
end

if hero.dead?
  puts "\n\n You could not make it"
else
  puts "\n\n You WON"
  puts "You earned #{hero.gold} gold and #{hero.exp} experience"
  puts "You killed monster #{kills} and fled from #{flees}"
end