module CardsLib
  module IsSet
    class << self
      def verify(cards, rules = [:unique, :paired], specs = {})
        max = specs.fetch(:max) {Float::INFINITY}
        min = specs.fetch(:min) { 3 }
        rules.all? {|r| send(r, cards) } && (min..max).include?(cards.count)
      end

      private 
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
end
