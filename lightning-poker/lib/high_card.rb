require 'card'
require 'fileutils'

module HighCard
  def self.beats?(hand, opposing)
    temp = [hand, opposing]
    # temp = [[10H, JH, AS], [QH, KC]]

    # how multi-dimensional arrays are sorted and compared
    # http://matthewsessions.com/2017/12/01/ruby-array-sorting.html

    temp.sort_by! do |h|
      # h = [10H, JH, AS]
      # h = [QH, KC]
      m = h.map(&:rank).
      # m = [10, 11, 14]
      # m = [12, 13]
      sort.reverse
      # m = [14, 11, 10]
      # m = [13, 12]
    end

    # temp = [[QH, KC], [10H, JH, AS]]
    winning = temp.last
    hand == winning
  end
end
