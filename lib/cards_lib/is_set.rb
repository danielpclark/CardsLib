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
        cards.combination(2).all? {|a, b| a != b }
      end

      using Refinements::InjectWhile

      def paired(cards)
        cards.inject_while?(:paired?)
      end

      def suited(cards)
        cards.inject_while?(:suited?)
      end

      def ordered(cards)
        cards.sort.inject_while?(:ordered?)
      end
    end
  end
end
