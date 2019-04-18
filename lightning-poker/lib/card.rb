require 'json'

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
    to_s
  end

  def to_s
    id = if rank > 10
           {
               11 => "J",
               12 => "Q",
               13 => "K",
               14 => "A"
           }.fetch(rank)
         else
           rank.to_s
         end

    s = {
        # hearts: "♡ ",
        # spades: "♤ ",
        # diamonds: "♢ ",
        # clubs: "♧ ",
        hearts: "H",
        spades: "S",
        diamonds: "D",
        clubs: "C",
    }

    "#{id.upcase}#{s.fetch(suit)}"
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

  def to_json
    {
        rank: rank,
        suit: suit
    }.to_json
  end

  def self.from_string(value)
    # get the last char of the string
    short_suit = value[-1]

    # Map it to a suit
    suits_hash = {
        "H" => :hearts,
        "D" => :diamonds,
        "S" => :spades,
        "C" => :clubs
    }
    # fetch in this case will raise an exception if key is not found
    suit = suits_hash.fetch(short_suit)

    # Map the initial chars to a face card or a number
    rank_hash = {
        'A' => :ace,
        'K' => :king,
        'Q' => :queen,
        'J' => :jack
    }
    first_char = value[0]
    # tries to get it the rank from the hash or_else falls-back to to_i
    rank = rank_hash.fetch(first_char) { value[0..-2].to_i }

    Card.build(suit, rank)
  end
end
