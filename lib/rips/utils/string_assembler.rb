module Rips
  module Utils
    module StringAssemblerExtension

      def del(regexp)
        gsub(regexp,'')
      end

      def del!(regexp)
        gsub!(regexp,'')
      end

    end
  end
end