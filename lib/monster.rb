class Monster
  attr_reader :toughness, :damage, :notice, :gold, :exp

  def initialize(opts = {})
    @toughness = opts.fetch(:toughness, 2)
    @damage = opts.fetch(:damage, 2)
    @notice = opts.fetch(:notice, 2)
    @gold = opts.fetch(:gold, 2)
    @exp = opts.fetch(:exp, 2)
    @dead = false
  end

  def dead?
    @dead
  end

  def kill
    @dead = true
  end
end