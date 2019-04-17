# A playing card of the game
class Card
  # e.g. spades, hearts
  attr_reader :suit
  attr_reader :rank

  # refactored to hide the new method
  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end

  # refactored to hide the 'new' method
  private_class_method :new

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
            when :jack then 11
            when :queen then 12
            when :king then 13
            when :ace then 14
            else rank
            end
  end

  def inspect
    "<Card #{rank} #{suit}>"
  end

  def ==(other)
    @suit == other.suit && @rank == other.rank
  end

  def hash
    [rank, suit].hash
  end

  def eql?(other)
    self == other
  end
end
