module CardsLib
  module Standard
    module Rules
      module Poker
        def self.precedence
          [
            :royal_flush, :straight_flush, :four_of_a_kind,
            :full_house, :flush, :straight,
            :three_of_a_kind, :two_pair, :one_pair,
            :high_card
          ]
        end
        
        def self.royal_flush(cards)
          cards if IsSet.verify(cards, [:suited]) && straight_to_ace(cards)
        end

        def self.straight_flush(cards)
          cards if IsSet.verify(cards, [:unique, :ordered, :suited], {min: 5, max: 5})
        end
        
        def self.four_of_a_kind(cards)
          cards if IsSet.verify(cards, [:unique, :paired], {min: 4, max: 4})
        end
        
        def self.full_house(cards)
          pair, set = cards.group_by(&:rank).values.sort
          cards if pair.inject(:pair?) && IsSet.verify(set, [:unique, :paired], {min:3, max: 3})
        end
        
        def self.flush(cards)
          cards if IsSet.verify(cards, [:unique, :suited], {min: 5, max: 5})
        end

        def self.straight(cards)
          cards if IsSet.verify(cards, [:unique, :ordered], {min: 5, max: 5}) ||
            straight_to_ace(cards)
        end

        def self.three_of_a_kind(cards)
          cards if IsSet.verify(cards, [:unique, :paired], {min:3, max: 3})
        end

        def self.two_pair(cards)
          pair1, pair2 = cards.group_by(&:rank).values.sort
          cards if pair1.inject(:pair?) && pair2.inject(:pair?)
        end

        def self.one_pair(cards)
          cards if IsSet.verify(cards, [:unique, :paired], {min:2, max: 2})
        end

        def self.high_card(cards)
          cards.detect {|c| c.rank[/\AA/]} || cards.sort.pop
        end

        class << self 
          def straight_to_ace(cards)
            cards.sort.map(&:rank) == Cards[*%w[As Ks Qs Js Ts]].sort.map(&:rank)
          end
          private :straight_to_ace
        end
      end
    end
  end
end
