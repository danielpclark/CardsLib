module CardsLib
  class Deck
    def initialize(cards = Standard::PLAYING_CARDS)
      @cards = cards.map {|c| Card.new(c) }
    end
  end
end
