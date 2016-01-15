module CardsLib
  class Deck
    def initialize(options = {})
      cards = options.fetch(:cards) { Standard::PLAYING_CARDS }
      @seed = options.fetch(:seed)  { Random.new.seed         }
      @top = 0
      @cards = cards.map {|c| Card.new(c) }.shuffle(random: Random.new(@seed)).to_enum
    end

    def inspect
      "<Deck: #{size} Cards - Seed##{@seed}>"
    end

    def cards
      @cards
    end

    def peak
      Array(_cards[@top..@top]).first
    end

    def pluck
      card = peak
      @top += 1 unless @top == _cards.size
      card || card.tap {|i| i.define_singleton_method(:face) { nil } }
    end

    def return_card
      @top -= 1 unless @top == 0
    end

    def empty?
      !peak
    end

    def present?
      !empty?
    end

    def size
      _cards[@top..-1].size
    end

    def count
      size
    end

    def face_up
      @cards.map(&:face)
    end

    private

    def _cards
      @cards.to_a
    end
  end
end
