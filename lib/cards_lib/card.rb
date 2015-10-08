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

    def sequential(other)
      @ranker.sequential(other)
    end
  end

  class InvalidCardFace < Exception

  end
end
