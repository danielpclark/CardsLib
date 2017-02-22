require 'minitest_helper'
include CardsLib

describe "Set Evaluator" do
  it "Confirms three of a kind" do
    assert IsSet.verify(Cards["Ah", "Ac", "Ad"])
    refute IsSet.verify(Cards["Ah", "2h", "Ad"])
  end

  it "Knows sequential cards are only 1 step from each other" do
    refute IsSet.verify(Cards["As", "3s", "5s", "7s", "9s"], [:unique, :suited, :ordered])
    assert IsSet.verify(Cards["As", "2s", "3s", "4s", "5s"], [:unique, :suited, :ordered])
  end

  it "Confirms set of 5 ordered spades" do
    assert IsSet.verify(Cards["As", "2s", "3s", "4s", "5s"], [:unique, :suited, :ordered])
    refute IsSet.verify(Cards["As", "2s", "Qs", "4s", "5s"], [:unique, :suited, :ordered])
  end

  it "Keeps in boundry limits" do
    refute IsSet.verify(Cards["Ah"], [], {min: 3, max: 5})
    refute IsSet.verify(Cards["Ah", "2h", "3h", "4h", "5h", "6h"], [], {min: 3, max: 5})
  end
end
