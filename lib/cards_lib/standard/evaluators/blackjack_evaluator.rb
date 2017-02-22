module CardsLib
  module Standard
    module Evaluators
      class BlackjackEvaluator
        def initialize(cards)
          @cards = cards
          @reduced_ace_count = 0
        end

        def worth
          @worth ||= @cards.map(&:value).inject(:+)
          if @worth > 21
            attempt = reduce_by_ace
            attempt = reduce_by_ace until @worth < 22 || !attempt
          end
          @worth
        end

        private
        def reduce_by_ace
          if count_aces > @reduced_ace_count
            @worth -= 10
            @reduced_ace_count += 1
            true
          else
            false
          end
        end

        def count_aces
          @cards.count {|c| c.rank == "A"}
        end
      end
    end
  end
end
