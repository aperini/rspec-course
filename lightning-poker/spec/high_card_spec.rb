require 'high_card'

describe 'hand rankings', :aggregate_failures do

  matcher :beat do |losing|
    match do |winning|
      HighCard.beats?(hand(winning), hand(losing))
    end

    failure_message do |winning|
      "expected <#{hand(winning).join(' ')}> to beat <#{hand(losing).join(' ')}>"
    end

    failure_message_when_negated do |winning|
      "expected <#{hand(winning).join(' ')}> to not beat <#{hand(losing).join(' ')}>"
    end
  end

  def hand(strings)
    strings.map { |x| Card.from_string(x) }
  end

  # %w defines an array of strings separated by spaces
  # e.g.
  # ['10H'] is the same of %w(10H)

  example 'hand with highest card wins' do
    expect(HighCard.beats?(hand(['JH']), hand(['10H']))).to eq(true)
    expect(%w(JH)).to beat(%w(9H))
    expect(%w(10H JH AS)).to beat(%w(QH KC))

    expect(%w(9H)).to_not beat(%w(JH))
    expect(%w(QH KC)).to_not beat(%w(10H JH AS))
  end

  example 'next highest card is used as tie braker' do
    expect(%w(10H 9H)).to beat(%w(10H 8H))
    expect(%w(10H 10D 9H)).to beat(%w(10H 10D 8H))
  end
end
