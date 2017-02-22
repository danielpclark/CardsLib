module CardsLib
  class Ranker
    include Comparable
    attr_reader :rank, :rank_lookup
    # Initialize's arguments:
    # rank        - is whatever part of the object, or the object itself you choose to use.
    # ranks       - is a simple hash to lookup a cards value with the keys matching the rank object.
    # rank_lookup - is an optional Proc to redefine how you will lookup a cards value.
    def initialize(rank = nil, ranks = nil, rank_lookup = nil)
      @rank = rank
      @ranks = ranks
      @rank_lookup = rank_lookup
    end

    def ranks
      @ranks || Standard::RANKS
    end

    def ranker(rank_face = @rank)
      if @rank_lookup
        @rank_lookup.(rank_face)
      else
        ranks.index(rank_face).to_i + 1
      end
    end

    def <=>(other)
      ranker(rank) <=> ranker(other.rank)
    end

    def sequential?(other)
      (ranker(rank) - ranker(other.rank)).abs == 1
    end
  end
end
