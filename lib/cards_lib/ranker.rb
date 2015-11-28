module CardsLib
  class Ranker
    include Comparable
    attr :rank, :ranks, :rank_lookup
    def initialize rank = nil,
                   ranks: "A23456789TJQK".chars,
                   rank_lookup: nil
    
      @rank, @ranks, @rank_lookup = rank, ranks, rank_lookup ||
                     ->rank_face{ @ranks.index(rank_face).to_i + 1 }
    end

    def <=>(item)
      @rank_lookup[self.rank] <=> @rank_lookup[item.rank]
    end

    def sequential?(item)
      (@rank_lookup[self.rank] - @rank_lookup[item.rank]).abs == 1
    end
  end
end
