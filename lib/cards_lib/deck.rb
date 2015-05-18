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

    def peak
      @cards.to_a[@top..@top].first
    end

    def pluck
      card = @cards.to_a[@top..@top].first
      @top += 1
      card
    end

    def return_card
      @top -= 1 unless @top == 0
    end
  end
end
