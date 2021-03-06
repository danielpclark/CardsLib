module CardsLib
  class Card
    include Comparable
    def initialize(face, ranker = Ranker)
      raise InvalidCardFace, "Parameter face cannot be blank!" if face.to_s.empty?
      @suit = if_hash_then_fetch(face, :suit)
      @rank = if_hash_then_fetch(face, :rank)
      @face = face_from_rank_and_suit(@rank, @suit) if face.is_a? Hash

      @face ||= face
      @ranker = ranker.new(rank)
    end

    def inspect
      "(Card)"
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

    def value
      @ranker.ranker
    end

    def pair?(other)
      rank == other.rank
    end

    # equal by both rank and suit
    def ==(other)
      pair?(other) && suit == other.suit
    end

    # equal by value
    def eql?(other)
      value == other.value
    end

    def <=>(other)
      @ranker.<=>(other)
    end

    def sequential?(other)
      @ranker.sequential?(other)
    end

    # return other if true
    def paired?(other)
      (rank == other.rank) ? other : nil
    end

    # return other if true
    def suited?(other)
      (suit == other.suit) ? other : nil
    end

    # returns other if true
    def ordered?(other)
      sequential?(other) ? other : nil
    end

    private
    def face_from_rank_and_suit(rank, suit)
      if rank && suit
        [rank, ((rank.length.>(1) && suit.length.>(1)) ? " of " : ""), suit].join
      else
        raise InvalidRankAndSuit, "Suit and Rank provided in Hash are invalid!"
      end
    end

    def if_hash_then_fetch(item, target)
      item.is_a?(Hash) ? item.fetch(target) { nil } : nil
    end

  end

  class InvalidCardFace < Exception; end
  class InvalidRankAndSuit < Exception; end
end
