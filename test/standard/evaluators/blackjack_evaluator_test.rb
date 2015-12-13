require 'minitest_helper'

include CardsLib::Standard::Evaluators

BlackCards = ->*c{ c.map {|face| Card.new(face, CardsLib::Standard::Rankers::BlackjackRanker) }}

describe BlackjackEvaluator do

  it "Knows Blackjack" do
    _(BlackjackEvaluator.new(
      BlackCards["As","Js"]
    ).worth).must_equal 21
  end

  it "Knows to drop Aces value when over" do
    _(BlackjackEvaluator.new(
      BlackCards["As","Js","Ks"]).worth
     ).must_equal 21

    _(BlackjackEvaluator.new(
      BlackCards["Ks","7h","Ac"]
    ).worth).must_equal 18

    _(BlackjackEvaluator.new(
      BlackCards["As","9h","Ac","9c"]
    ).worth).must_equal 20

    _(BlackjackEvaluator.new(
      BlackCards["As","Ah","Ac","Ad"]
    ).worth).must_equal 14

    _(BlackjackEvaluator.new(
      BlackCards["As","Ah","Ac","Ad","Kd"]
    ).worth).must_equal 14
  end

end
