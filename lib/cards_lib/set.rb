module CardsLib
  class Set
    def initialize(cards, rules = {})
      @cards = cards
      @max = rules.delete(:max) || Float::INFINITY
      @min = rules.delete(:min) || 3
      rules.all? {|r| send(r, cards) } && (@min..@max).include?(cards.count)
    end

    def unique(cards)
      cards.combination(2).all? {|a,b| a != b }
    end

    def paired(cards)
      !(cards.inject(:paired?).is_a? NilCard)
    end
    
    def suited(cards)
      !(cards.inject(:suited?).is_a? NilCard)
    end

    def ordered(cards)
      !(cards.sort.inject(:ordered?).is_a? NilCard)
    end

  end
end
