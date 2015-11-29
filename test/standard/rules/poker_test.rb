require 'minitest_helper'

include CardsLib::Standard::Rules

describe Poker do
  it "Has ordered rules" do
    _(Poker.precedence).must_be :first
  end

  it "Knows a Royal Flush" do
    cards = Cards[*%w[As Ks Qs Js Ts]]
    _(Poker.royal_flush(cards)).must_be_same_as cards
  end

  it "Knows a Straight Flush" do
    cards = Cards[*%w[9s Ks Qs Js Ts]]
    _(Poker.straight_flush(cards)).must_be_same_as cards
  end

  it "Knows about Four of a Kind" do
    cards = Cards[*%w[Kh Kc Kd Ks]]
    _(Poker.four_of_a_kind(cards)).must_be_same_as cards
    refute Poker.four_of_a_kind( Cards[*%w[Ks Ks Ks Ks]] )
  end

  it "Knows about Full House" do
    cards = Cards[*%w[Ah Ac Kc Kd Ks]]
    _(Poker.full_house(cards)).must_be_same_as cards
    refute Poker.full_house( Cards[*%w[As Qd Ks Ks Ks]] )
  end

  it "Knows about Flush" do
    cards = Cards[*%w[2s 4s 5s 7s 8s]]
    _(Poker.flush(cards)).must_be_same_as cards
    refute Poker.flush( Cards[*%w[Qs Ks As 2s 4h]] )
  end

  it "Knows a Straight" do
    cards = Cards[*%w[9c Ks Qs Js Ts]]
    _(Poker.straight(cards)).must_be_same_as cards
    cards = Cards[*%w[Ac Ks Qs Js Ts]]
    _(Poker.straight(cards)).must_be_same_as cards
  end

  it "Knows Three of a Kind" do
    cards = Cards[*%w[9c 9s 9d]]
    _(Poker.three_of_a_kind(cards)).must_be_same_as cards
  end
  
  it "Knows Two Pair" do
    cards = Cards[*%w[9c 9s 7d 7h]]
    _(Poker.two_pair(cards)).must_be_same_as cards
  end

  it "Knows a Pair" do
    cards = Cards[*%w[9c 9s]]
    _(Poker.one_pair(cards)).must_be_same_as cards
  end

  it "Returns high card" do
    cards = Cards[*%w[As Kd 2h 9c 9s]]
    _(Poker.high_card(cards)).must_equal Card.new("As")
    cards = Cards[*%w[2s 2d 2h 2c 3s]]
    _(Poker.high_card(cards)).must_equal Card.new("3s")
    cards = Cards[*%w[4s Jd 2h 7c 9s]]
    _(Poker.high_card(cards)).must_equal Card.new("Jd")
  end
end
