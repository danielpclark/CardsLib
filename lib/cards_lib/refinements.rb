module CardsLib::Refinements
  module InjectWhile
    refine Array do
      def inject_while?(m)
        result, *array = self.dup
        loop do
          break if array.empty?
          other = array.shift

          result = result.send(m, other)
          return false unless result
        end
        true
      end
    end
  end
end
