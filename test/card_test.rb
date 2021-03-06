require 'minitest_helper'

describe "Card" do
  it "Creates a Card" do
    card = Card.new("Ah")
    card.face.must_equal "Ah"
    _(card.inspect).must_equal "(Card)"
  end

  it "Must raise InvalidCardFace for empty string" do
    -> { Card.new("") }.must_raise InvalidCardFace
  end

  it "Must raise InvalidSuitAndRank for empty Hash" do
    -> { Card.new({}) }.must_raise InvalidRankAndSuit
  end

  it "Knows its rank" do
    card = Card.new("Ah")
    card.rank.must_equal "A"
  end

  it "Knows its value" do
    card = Card.new("4h")
    card.value.must_equal 4
  end

  it "Knows its suit" do
    card = Card.new("Ah")
    card.suit.must_equal "h"
  end

  it "Knows samesness :==" do
    card1 = Card.new("Ah")
    card2 = Card.new("Ah")

    _(card1).must_equal card2
  end

  it "Can create cards from rank and suit" do
    card = Card.new({suit: "Hearts", rank: "Jack"})
    card.face.must_equal "Jack of Hearts"
    card.suit.must_equal "Hearts"
    card.rank.must_equal "Jack"
    card = Card.new({suit: "h", rank: "J"})
    card.face.must_equal "Jh"
    card.suit.must_equal "h"
    card.rank.must_equal "J"
  end

  it "Knows ranks of cards" do
    "A23456789TJQK".split('').combination(2).each do |a, b|
      Card.new("#{a}h").must_be :<, Card.new("#{b}h")
    end
    "A23456789TJQK".split('').reverse.combination(2).each do |a, b|
      Card.new("#{a}h").must_be :>, Card.new("#{b}h")
    end
    "A23456789TJQK".split('').each do |a|
      Card.new("#{a}h").must_be :==, Card.new("#{a}h")
    end
  end

  it "Recognizes sequential ranks" do
    coupler = lambda do |str|
      arr = []
      str.length.times do |i|
        arr.push(str[i..i+1]) unless i == str.length - 1
      end
      arr
    end
    coupler.("A23456789TJQKQJT98765432A").each do |pair|
      Card.new("#{pair[0]}h").must_be :sequential?, Card.new("#{pair[1]}h")
    end
    coupler.("A3579JKAQT8642").each do |pair|
      Card.new("#{pair[0]}h").wont_be :sequential?, Card.new("#{pair[1]}h")
    end
  end

  it "can take spurious data" do
    # NOTE: You must build custom ranker if you want to take advantage of comparison.
    rank = :Ferrari
    suit = {km_h: 300, hp: 380, cc: 4390, cylinder: "V12", kg: 1120}
    c = Card.new rank: rank, suit: suit
    _(c.face).must_equal "Ferrari of {:km_h=>300, :hp=>380, :cc=>4390, :cylinder=>\"V12\", :kg=>1120}"
    _(c.suit).must_equal suit
    _(c.rank).must_equal rank
  end
end
