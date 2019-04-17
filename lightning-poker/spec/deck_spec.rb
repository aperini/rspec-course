require 'deck'
require 'debug_utils'

# defining our custom matcher for checking contiguous elements in an array
# Doing this inside a module so this hasn't a global scope

module ArrayMatchers
  extend RSpec::Matchers::DSL

  matcher :be_contiguous_by do
    # checks for the problem in question
    def first_non_contiguous_pair(array)
      debug_array(array)
      first_pair = array
                       .sort_by(&block_arg)
                       .each_cons(2)
                       .detect { |x, y| block_arg.call(x) + 1 != block_arg.call(y) }

      debug_first_pair(first_pair)
    end

    # executes the matcher logic
    match do |array|
      !first_non_contiguous_pair(array)
    end

    # customizes the error message
    failure_message do |array|
      pair = first_non_contiguous_pair(array)

      "%s and %s were not contiguous" % pair
    end
  end
end

# BDD for the Deck
describe 'Deck' do

  include ArrayMatchers

  describe '.all' do
    it 'contains 32 cards' do
      expect(Deck.all.length).to eq(32)
    end

    it 'has a 7 as its lowest card' do
      Deck.all.each do |card|
        expect(card.rank).to be >= 7
      end

      # OR
      expect(Deck.all.map { |card| card.rank }).to all(be >= 7)

      # OR
      expect(Deck.all).to all(have_attributes(rank: be >= 7))
    end

    it 'has contiguous ranks by suit' do

      # this way
      all_cards_array = Deck.all
      # groups elements by suit
      hash_by_suit = all_cards_array.group_by {|card| card.suit}

      hash_by_suit.each do |suit, cards|
        ranks = cards.map {|card| card.rank}
        sorted_ranks = ranks.sort
        consecutive_pairs = sorted_ranks.each_cons(2)
        contiguous = consecutive_pairs.all? { |x, y| x + 1 == y }
        # expect(contiguous).to eq(true)
      end

      # OR this way
      hash_by_suit = all_cards_array.group_by {|card| card.suit}
      groups_of_cards = hash_by_suit.values
      debug_groups(groups_of_cards)
      # the ALL gives us all relevant failures, not just the first one
      expect(groups_of_cards).to all(be_contiguous_by(&:rank))
    end
  end
end
