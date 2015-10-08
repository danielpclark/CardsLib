module CardsLib
  class Card
    include Comparable
    def initialize(face, ranker = Ranker)
      raise InvalidCardFace, "face cannot be blank" if face.to_s.empty?
      @suit = nil
      @rank = nil
      @ranker = ranker
      if face.is_a? Hash
        @suit = face.fetch(:suit) { nil }
        @rank = face.fetch(:rank) { nil }
        if @rank && @suit
          str = ""
          if @rank.length.>(1) && @suit.length.>(1)
            str = " of "
          end
          @face = [@rank, str, @suit].join
        end
      else
        @face = face
      end
      @ranker = ranker.new(rank)
    end

    def face
      @face   
    end

    def suit
      @suit || @face[1..-1]
    end

    def rank
      @rank || @face[0]
    end

    def <=>(other)
      @ranker.<=>(other)
    end
  end

  class InvalidCardFace < Exception

  end

  class Ranker
    include Comparable
    attr :rank, :ranks, :rank_lookup
    def initialize(
      rank = nil,
      ranks: "A23456789TJQK".split(''),
      rank_lookup: ->rank_face{
        r = @ranks.index(rank_face).to_i + 1
        # r = 10 if r > 10
        r
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
