# A plying card of the game
class Card
  # e.g. spades
  attr_reader :suit
  attr_reader :rank

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
            when :jack then 11
            when :queen then 12
            when :king then 13
            else rank
            end
  end
end

# Describe groups examples / properties
RSpec.describe 'a playing card' do
  # it specifies a particular property of the code, or an example
  it 'has a suit' do
    raise unless Card.new(suit: :spades, rank: 4).suit == :spades
  end

  it 'has a rank' do
    raise unless Card.new(suit: :spades, rank: 4).rank == 4
  end

  describe 'a jack' do
    it 'ranks higher than a 10' do
      lower = Card.new(suit: :spades, rank: 10)
      higher = Card.new(suit: :spades, rank: :jack)

      raise unless higher.rank > lower.rank
    end
  end

  describe 'a queen' do
    it 'ranks higher than a jack' do
      lower = Card.new(suit: :spades, rank: :jack)
      higher = Card.new(suit: :spades, rank: :queen)

      raise unless higher.rank > lower.rank
    end
  end

  describe 'a king' do
    it 'ranks higher than a queen' do
      lower = Card.new(suit: :spades, rank: :queen)
      higher = Card.new(suit: :spades, rank: :king)

      raise unless higher.rank > lower.rank
    end
  end
end
