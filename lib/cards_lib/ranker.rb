module CardsLib
  class Ranker
    include Comparable
    attr :rank, :rank_lookup
    # Initialize's arguments:
    # rank        - is whatever part of the object, or the object itself you choose to use.
    # ranks       - is a simple hash to lookup a cards value with the keys matching the rank object.
    # rank_lookup - is an optional Proc to redefine how you will lookup a cards value.
    def initialize(rank = nil, ranks = nil, rank_lookup = nil)
      @rank, @ranks, @rank_lookup = rank, ranks, rank_lookup
    end

    def ranks
      @ranks || Standard::RANKS
    end

    def ranker(rank_face = @rank)
      @rank_lookup ? @rank_lookup.(rank_face) :
      ranks.index(rank_face).to_i + 1
    end

    def <=>(item)
      ranker(self.rank) <=> ranker(item.rank)
    end

    def sequential?(item)
      (ranker(self.rank) - ranker(item.rank)).abs == 1
    end
  end
end
