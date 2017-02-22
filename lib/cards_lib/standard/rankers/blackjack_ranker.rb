module CardsLib
  module Standard
    module Rankers
      class BlackjackRanker < CardsLib::Ranker
        def initialize(card)
          super(
            card,
            {
              "2" => 2,
              "3" => 3,
              "4" => 4,
              "5" => 5,
              "6" => 6,
              "7" => 7,
              "8" => 8,
              "9" => 9,
              "T" => 10,
              "J" => 10,
              "Q" => 10,
              "K" => 10,
              "A" => 11
            },
            ->rank{@ranks[rank]}
          )
        end
      end
    end
  end
end
