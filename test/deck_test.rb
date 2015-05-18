require 'minitest_helper'

describe "Deck" do

  let :deck do
    deck = Deck.new cards: Standard::PLAYING_CARDS, seed: 251553915998611004040618191571517194611
    
    if RUBY_VERSION =~ /1.9/
      deck.instance_eval {
        @cards = [
          "h9", "s4", "s2", "h2", "s9", "dA", "sK", "c8", "d6",
          "c4", "sJ", "cJ", "c5", "cT", "cK", "c2", "d4", "h3",
          "dQ", "hJ", "s3", "h8", "h6", "d2", "dK", "d8", "h5",
          "s5", "sA", "c3", "s7", "cA", "hA", "d9", "s8", "h4",
          "sQ", "d5", "hK", "d3", "d7", "hQ", "c6", "dJ", "hT",
          "s6", "c7", "h7", "cQ", "dT", "c9", "sT"
        ].map {|c| Card.new(c)}.to_enum
      }
    end

    deck
  end

  it "Creates a deck" do
    deck.cards.map(&:face).sort.must_equal Standard::PLAYING_CARDS.sort
  end

  it "Returns the cards as an enumerator" do
    deck.is_a? Enumerator
  end

  it "Can load a deck based on the random seed" do
    deck.cards.map(&:face).take(5).must_equal ["h9", "s4", "s2", "h2", "s9"]
  end

  it "Let's you peak at the top card" do
    deck.peak.face.must_equal "h9"
    deck.pluck
    deck.peak.face.must_equal "s4"
  end

  it "Let's you pluck a card from the deck" do
    card = deck.pluck
    card.face.must_equal "h9"
    deck.peak.face.must_equal "s4"
  end

  it "Lets you return a card to the deck" do
    deck.pluck
    deck.pluck
    deck.peak.face.must_equal "s2"
    deck.return_card
    deck.peak.face.must_equal "s4"
  end

  it "Gets to the last card of the deck just swell" do
    51.times { deck.pluck }
    deck.pluck.face.must_equal "sT"
    card = deck.pluck
    card.must_be_nil    
    card.face.must_be_nil
  end

  it "Doesn't over draw from deck" do
    55.times { deck.pluck }
    deck.return_card
    deck.peak.face.must_equal "sT"
  end

  it "Knows when the deck is :empty?" do
    deck.wont_be :empty?
    52.times { deck.pluck }
    deck.must_be :empty?
  end

  it "Knows when cards are :present?" do
    deck.must_be :present?
    52.times { deck.pluck }
    deck.wont_be :present?
  end

  it "Knows the deck :size" do
    deck.size.must_equal 52
    deck.count.must_equal 52
    deck.pluck
    deck.size.must_equal 51
    deck.count.must_equal 51
    50.times { deck.pluck }
    deck.size.must_equal 1
    deck.count.must_equal 1
    deck.pluck
    deck.size.must_equal 0
    deck.count.must_equal 0
    deck.pluck
    deck.size.must_equal 0
    deck.count.must_equal 0
  end

  it "Can show the cards :face_up" do
    deck.face_up.take(5).must_equal ["h9", "s4", "s2", "h2", "s9"]
  end
end
