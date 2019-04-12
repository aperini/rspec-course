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
