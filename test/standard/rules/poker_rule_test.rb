require 'minitest_helper'

include CardsLib::Standard::Rules

describe PokerRule do
  it "Has ordered rules" do
    _(PokerRule.precedence).must_be :first
  end

  it "Knows a Royal Flush" do
    cards = Cards[*%w(As Ks Qs Js Ts)]
    _(PokerRule.royal_flush(cards)).must_be_same_as cards
  end

  it "Knows a Straight Flush" do
    cards = Cards[*%w(9s Ks Qs Js Ts)]
    _(PokerRule.straight_flush(cards)).must_be_same_as cards
  end

  it "Knows about Four of a Kind" do
    cards = Cards[*%w(Kh Kc Kd Ks)]
    _(PokerRule.four_of_a_kind(cards)).must_be_same_as cards
    refute PokerRule.four_of_a_kind( Cards[*%w(Ks Ks Ks Ks)] )
  end

  it "Knows about Full House" do
    cards = Cards[*%w(Ah Ac Kc Kd Ks)]
    _(PokerRule.full_house(cards)).must_be_same_as cards
    refute PokerRule.full_house( Cards[*%w(As Qd Ks Ks Ks)] )
  end

  it "Knows about Flush" do
    cards = Cards[*%w(2s 4s 5s 7s 8s)]
    _(PokerRule.flush(cards)).must_be_same_as cards
    refute PokerRule.flush( Cards[*%w(Qs Ks As 2s 4h)] )
  end

  it "Knows a Straight" do
    cards = Cards[*%w(9c Ks Qs Js Ts)]
    _(PokerRule.straight(cards)).must_be_same_as cards
    cards = Cards[*%w(Ac Ks Qs Js Ts)]
    _(PokerRule.straight(cards)).must_be_same_as cards
  end

  it "Knows Three of a Kind" do
    cards = Cards[*%w(9c 9s 9d)]
    _(PokerRule.three_of_a_kind(cards)).must_be_same_as cards
  end

  it "Knows Two Pair" do
    cards = Cards[*%w(9c 9s 7d 7h)]
    _(PokerRule.two_pair(cards)).must_be_same_as cards
  end

  it "Knows a Pair" do
    cards = Cards[*%w(9c 9s)]
    _(PokerRule.one_pair(cards)).must_be_same_as cards
  end

  it "Returns high card" do
    cards = Cards[*%w(As Kd 2h 9c 9s)]
    _(PokerRule.high_card(cards)).must_equal Card.new("As")
    cards = Cards[*%w(2s 2d 2h 2c 3s)]
    _(PokerRule.high_card(cards)).must_equal Card.new("3s")
    cards = Cards[*%w(4s Jd 2h 7c 9s)]
    _(PokerRule.high_card(cards)).must_equal Card.new("Jd")
  end
end
