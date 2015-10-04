module CardsLib
  class Card
    def initialize(face)
      raise InvalidCardFace, "face cannot be blank" if face.to_s.empty?
      @suit = nil
      @rank = nil
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
  end

  class InvalidCardFace < Exception

  end
end
