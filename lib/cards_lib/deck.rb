module CardsLib
  class Deck
    def initialize(cards = Standard::PLAYING_CARDS, options = {})
      @seed = options.fetch(:seed) { Random.new.seed }
      @top = 0
      @cards = cards.map {|c| Card.new(c) }.shuffle(random: Random.new(@seed)).to_enum
    end

    def cards
      @cards
    end
  end
end
