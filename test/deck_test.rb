require 'minitest_helper'

describe "Deck" do

  it "Creates a deck" do
    deck = Deck.new(Standard::PLAYING_CARDS)
    deck.cards.map(&:face).sort.must_equal Standard::PLAYING_CARDS.sort
  end

  it "Can load a deck based on the random seed" do
    deck = Deck.new Standard::PLAYING_CARDS, seed: 251553915998611004040618191571517194611
    deck.cards.map(&:face).take(5).must_equal ["h9", "s4", "s2", "h2", "s9"]
  end
end
