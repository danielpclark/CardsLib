require 'minitest_helper'

describe "Card" do
  it "Creates a Card" do
    card = Card.new("Ah")
    card.face.must_equal "Ah"
  end

  it "Must raise InvalidCardFace for empty string" do
    -> { Card.new("") }.must_raise InvalidCardFace
  end
end
