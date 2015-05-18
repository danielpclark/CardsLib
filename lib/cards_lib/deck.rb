module CardsLib
  class Deck
    def initialize(options = {})
      cards = options.fetch(:cards) { Standard::PLAYING_CARDS }
      @seed = options.fetch(:seed)  { Random.new.seed         }
      @top = 0
      @cards = cards.map {|c| Card.new(c) }.shuffle(random: Random.new(@seed)).to_enum
    end

    def cards
      @cards
    end

    def peak
      Array(@cards.to_a[@top..@top]).first
    end

    def pluck
      card = Array(@cards.to_a[@top..@top]).first
      @top += 1 unless @top == cards.to_a.size
      card || card.tap {|i| i.define_singleton_method(:face) { nil } }
    end

    def return_card
      @top -= 1 unless @top == 0
    end
  end
end
