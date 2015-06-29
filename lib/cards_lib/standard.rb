module CardsLib
  module Standard
    PLAYING_CARDS = 'A23456789TJQK'.chars.product('cdhs'.chars).map(&:join)
    ASCII_CARDS   = 'A23456789TJQK'.chars.product('♣♦♥♠'.chars).map(&:join)
  end
end
