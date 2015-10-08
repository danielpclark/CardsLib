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
    "A23456789TJQK".split('').combination(2).each {|a,b|
      Card.new("#{a}h").must_be :<, Card.new("#{b}h")
    }
    "A23456789TJQK".split('').reverse.combination(2).each {|a,b|
      Card.new("#{a}h").must_be :>, Card.new("#{b}h")
    }
    "A23456789TJQK".split('').each {|a|
      Card.new("#{a}h").must_be :==, Card.new("#{a}h")
    }
  end

  it "Recognizes sequential ranks" do
    coupler = ->str{
      arr = []
      str.length.times {|i|
        arr.push(str[i..i+1]) unless i == str.length - 1
      }
      arr
    }
    coupler.("A23456789TJQKQJT98765432A").each do |pair|
      Card.new("#{pair[0]}h").must_be :sequential, Card.new("#{pair[1]}h")
    end
    coupler.("A3579JKAQT8642").each do |pair|
      Card.new("#{pair[0]}h").wont_be :sequential, Card.new("#{pair[1]}h")
    end
  end
end
