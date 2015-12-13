require_relative 'standard/rules'
require_relative 'standard/rankers'
require_relative 'standard/evaluators'

module CardsLib
  module Standard
    RANKS         = 'A23456789TJQK'.chars
    SUITS         = 'cdhs'.chars
    PLAYING_CARDS = RANKS.product(SUITS       ).map(&:join)
    ASCII_CARDS   = RANKS.product('♣♦♥♠'.chars).map(&:join)
  end
end
