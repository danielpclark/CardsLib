require 'minitest_helper'

describe "Deck" do
  it "Creates a Deck" do
    deck = Deck.new(Standard::PLAYING_CARDS)
    deck.cards.map(&:face).sort.must_equal Standard::PLAYING_CARDS.sort
  end
end
