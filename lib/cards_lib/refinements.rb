module CardsLib::Refinements
  module ClassyInject
    refine Array do
      # Ends quickly on DuckType change
      def inject(m)
        ar = self.dup
        result = ar.shift
        brk = false
        loop do
          break if ar.empty?
          other = ar.shift
          brk = result.class != other.class
          result = result.send(m, other)
          break if brk
        end
        result
      end
    end
  end
end
