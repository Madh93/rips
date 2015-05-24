module Rips
  module Utils
    module ArrayExtension

      # Binary search or standard search depends version
      def search(&block)
        RUBY_VERSION >= "2" ? self.bsearch(&block) : self.find(&block)
      end

    end
  end
end