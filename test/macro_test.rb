require 'minitest_helper'

describe "Cards Macro" do
  it "Creates a Card" do
    card = Cards["Ah"].first
    card.face.must_equal "Ah"
    _(card.inspect).must_equal "(Card)"
  end

  it "Creates two Cards" do
    card, card2 = Cards["Ah", "2h"]
    card.face.must_equal "Ah"
    card2.face.must_equal "2h"
  end

  it "Can take custom Rankers" do
    card, card2 = Cards[["Ah", Ranker], ["2h", CardsLib::Standard::Rankers::BlackjackRanker]]
    card.face.must_equal "Ah"
    _(card.instance_variable_get(:@ranker)).
      must_be_kind_of CardsLib::Ranker
    card2.face.must_equal "2h"
    _(card2.instance_variable_get(:@ranker)).
      must_be_kind_of CardsLib::Standard::Rankers::BlackjackRanker
  end
end
