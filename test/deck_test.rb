require 'minitest_helper'

describe "Deck" do

  let :deck do
    deck = Deck.new cards: Standard::PLAYING_CARDS, seed: 251553915998611004040618191571517194611

    if RUBY_VERSION =~ /1.9/
      deck.instance_eval {
        @cards = [
          "9h", "Jh", "Jc", "7s", "Qs", "4d", "Ks", "2s", "5h",
          "As", "Kd", "3h", "2c", "3d", "4c", "Ad", "5c", "8c",
          "7c", "Tc", "Jd", "9d", "8s", "4h", "7d", "6c", "8h",
          "Js", "Ts", "Ah", "Qd", "Ac", "7h", "6d", "Qh", "8d",
          "Kh", "5d", "Th", "4s", "5s", "Td", "2d", "6s", "9s",
          "Qc", "2h", "9c", "3s", "6h", "3c", "Kc"
        ]
      }
    end

    deck
  end

  it "Creates a deck" do
    deck.cards.map(&:face).sort.must_equal Standard::PLAYING_CARDS.sort
    _(deck.inspect).must_equal "<Deck: 52 Cards - Seed#251553915998611004040618191571517194611>"
  end

  it "Returns the cards as an enumerator" do
    deck.is_a? Enumerator
  end

  it "Can load a deck based on the random seed" do
    deck.cards.map(&:face).take(5).must_equal ["9h", "Jh", "Jc", "7s", "Qs"]
  end

  it "Let's you peak at the top card" do
    deck.peak.face.must_equal "9h"
    deck.pluck
    deck.peak.face.must_equal "Jh"
  end

  it "Let's you pluck a card from the deck" do
    card = deck.pluck
    card.face.must_equal "9h"
    deck.peak.face.must_equal "Jh"
  end

  it "Lets you return a card to the deck" do
    deck.pluck
    deck.pluck
    deck.peak.face.must_equal "Jc"
    deck.return_card
    deck.peak.face.must_equal "Jh"
  end

  it "Gets to the last card of the deck just swell" do
    51.times { deck.pluck }
    deck.pluck.face.must_equal "Kc"
    card = deck.pluck
    card.must_be_nil    
    card.face.must_be_nil
  end

  it "Doesn't over draw from deck" do
    55.times { deck.pluck }
    deck.return_card
    deck.peak.face.must_equal "Kc"
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
    deck.face_up.take(5).must_equal ["9h", "Jh", "Jc", "7s", "Qs"]
  end

  it "Takes a custom Ranker for each Card" do
    class CustomRanker < CardsLib::Ranker
      def initialize(card)
        super(
          card,
          {
            "A" => 1,
            "2" => 2,
            "3" => 3,
            "4" => 4,
            "5" => 5,
            "6" => 6,
            "7" => 7,
            "8" => 8,
            "9" => 9,
            "T" => 10,
            "J" => 11,
            "Q" => 12,
            "K" => 13
          },
          ->rank{@ranks[rank]}
        )
      end
    end
    custom = Deck.new cards: Standard::PLAYING_CARDS,
      seed: 251553915998611004040618191571517194611,
      ranker: CustomRanker
    a = custom.pluck
    _(a.value).must_equal 9
    b = custom.pluck
    _(b).must_be :>, a # J > 9
    _(b.value).must_equal 11
    c = custom.pluck
    _(c).must_be :eql?, b # J == J
    _(c).must_be :>=, b # J == J
    _(c).must_be :<=, b # J == J
    _(c.value).must_equal 11
    
    # EXEPTION ON EQUALITY IMPLEMENTATION ON Card CLASS.
    # DON'T USE == FOR ONLY CHECKING THE VALUE.
    # USE :eql?
    _(c).wont_equal b

    d = custom.pluck
    _(d).must_be :<, c # 7 < J
    _(d.value).must_equal 7
    e = custom.pluck
    _(e).must_be :>, d # Q > 7
    _(e.value).must_equal 12
  end
end
