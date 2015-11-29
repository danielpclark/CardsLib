module CardsLib
  class Ranker
    include Comparable
    attr :rank, :rank_lookup
    def initialize rank = nil, ranks: nil, rank_lookup: nil
      @rank, @ranks, @rank_lookup = rank, ranks, rank_lookup
    end

    def ranks
      @ranks || Standard::RANKS
    end

    def ranker(rank_face)
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
