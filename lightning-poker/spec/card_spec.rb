# since Rspec adds the /lib dir to our path, we can require directly
require 'card'

# Describe groups examples / properties
describe Card do
  def card(params = {})
    defaults = {
      suit: :heart,
      rank: 7
    }
    Card.build(*defaults.merge(params).values_at(:suit, :rank))
  end

  # 'it' specifies a particular property of the code, or an example
  it 'has a suit' do
    expect(card(suit: :spades).suit).to eq(:spades)
  end

  it 'has a rank' do
    expect(card(rank: 4).rank).to eq(4)
  end

  # 'context' groups just like 'describe' does
  context 'equality' do
    # equivalent to let(:subject)
    subject { @subject ||= card(suit: :spades, rank: 4) }

    describe 'comparing against self' do
      def other
        @other ||= card(suit: :spades, rank: 4)
      end

      it 'is equal' do
        expect(subject).to eq(other)
      end

      it 'is hash equal' do
        expect(Set.new([subject, other]).size).to eq(1)
      end
    end

    shared_examples_for 'an unequal card' do
      it 'is not equal' do
        expect(subject).not_to eq(other)
      end

      it 'is not hash equal' do
        expect(Set.new([subject, other]).size).to eq(2)
      end
    end

    describe 'comparing to a card of different suit' do
      # Let defines a memoized helper method. The value will be cached across
      # multiple calls in the same example but not across examples
      let(:other) { card(suit: :hearts, rank: 4) }

      it_behaves_like 'an unequal card'
    end

    describe 'comparing to a card of different rank' do
      let(:other) { card(suit: :spades, rank: 5) }

      it_behaves_like 'an unequal card'
    end
  end

  describe 'a jack' do
    it 'ranks higher than a 10' do
      expect(card(rank: 10).rank).to be < card(rank: :jack).rank
    end
  end

  describe 'a queen' do
    it 'ranks higher than a jack' do
      expect(card(rank: :jack).rank).to be < card(rank: :queen).rank
    end
  end

  describe 'a king' do
    it 'ranks higher than a queen' do
      expect(card(rank: :queen).rank).to be < card(rank: :king).rank
    end
  end
end
