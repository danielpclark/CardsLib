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

    def pair?(other)
      self.rank == other.rank
    end

    def ==(other)
      pair?(other) && self.suit == other.suit
    end

    def <=>(other)
      @ranker.<=>(other)
    end

    def sequential(other)
      @ranker.sequential(other)
    end
    
    # return other if true
    def paired?(other)
      (self.rank == other.rank) ? other : NilCard.new
    end

    # return other if true
    def suited?(other)
      (self.suit == other.suit) ? other : NilCard.new
    end

    # returns other if true
    def ordered?(other)
      card.sequential(other) ? other : NilCard.new
    end
  end

  class InvalidCardFace < Exception

  end

  class NilCard
    def method_missing(m,*a,&b)
      self 
    end
  end
end
