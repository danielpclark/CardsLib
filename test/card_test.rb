require 'minitest_helper'

describe "Card" do
  it "Creates a Card" do
    card = Card.new("Ah")
    card.face.must_equal "Ah"
  end

  it "Must raise InvalidCardFace for empty string" do
    -> { Card.new("") }.must_raise InvalidCardFace
  end

  it "Knows its rank" do
    card = Card.new("Ah")
    card.rank.must_equal "A"
  end

  it "Knows its suit" do
    card = Card.new("Ah")
    card.suit.must_equal "h"
  end

  it "can create cards from rank and suit" do
    card = Card.new({suit: "Hearts", rank: "Jack"})
    card.face.must_equal "Jack of Hearts"
    card.suit.must_equal "Hearts"
    card.rank.must_equal "Jack"
    card = Card.new({suit: "h", rank: "J"})
    card.face.must_equal "Jh"
    card.suit.must_equal "h"
    card.rank.must_equal "J"
  end
end
