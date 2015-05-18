module CardsLib
  class Card
    def initialize(face)
      raise InvalidCardFace, "face cannot be blank" if face.to_s.empty?
      @face = face
    end

    def face
      @face   
    end
  end

  class InvalidCardFace < Exception

  end
end
