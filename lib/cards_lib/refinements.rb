module CardsLib::Refinements
  module InjectWhile
    refine Array do
      def inject_while?(m)
        result, *array = self.dup
        loop do
          break if array.empty?
          other = array.shift

          return false if result.class != other.class

          result = result.send(m, other)
        end
        true
      end
    end
  end
end
