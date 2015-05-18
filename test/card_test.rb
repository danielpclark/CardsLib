require 'minitest_helper'

describe "Card" do
  it "Creates a Card" do
    card = Card.new("Ah")
    card.face.must_equal "Ah"
  end
end
