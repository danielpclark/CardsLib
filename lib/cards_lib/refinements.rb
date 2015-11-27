module CardsLib::Refinements
  module ClassyInject
    refine Array do
      # Ends quickly on DuckType change (aka Lazy Typed Injector)
      # Designed for functional [self,other]->other forwardness
      def inject(m)
        result, *array = self.dup
        stop_iteration = false

        loop do
          break if array.empty?
          other = array.shift
          stop_iteration = result.class != other.class

          result = result.send(m, other)
          break if stop_iteration
        end
        result
      end
    end
  end
end
