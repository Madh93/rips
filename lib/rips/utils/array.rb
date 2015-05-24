module Rips
  module Utils
    module ArrayExtension

      # Binary search or standard search depends version
      def search(&block)
        if RUBY_VERSION >= "2"
          self.bsearch(block)
        else
          self.find(block)
        end
      end

    end
  end
end