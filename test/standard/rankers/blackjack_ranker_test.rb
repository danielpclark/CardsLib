require 'minitest_helper'
include CardsLib::Standard::Rankers

describe BlackjackRanker do
  let(:cards) { BlackCards["2s","3s","4s"] }

  it "Must have rank defined on its ranker" do
    _(cards.first.instance_eval {@ranker.instance_eval {@rank}}).must_equal "2"
  end

  it "Gets correct values from card" do
    _(cards.map(&:value)).must_equal [2,3,4]
  end

  it "Knows the 10 value equality" do
    BlackCards["Th","Jh","Qh","Kh"].combination(2).each do |a, b|
      _(a).must_be :eql?, b
    end
  end
end
