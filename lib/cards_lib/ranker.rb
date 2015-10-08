module CardsLib
  class Ranker
    include Comparable
    attr :rank, :ranks, :rank_lookup
    def initialize(
        rank = nil,
        ranks: "A23456789TJQK".split(''),
        rank_lookup: ->rank_face{
          @ranks.index(rank_face).to_i + 1
        })
      @rank = rank
      @ranks = ranks
      @rank_lookup = rank_lookup
    end

    def <=>(item)
      @rank_lookup[self.rank] <=> @rank_lookup[item.rank]
    end

    def inspect
      @rank
    end
  end
end
