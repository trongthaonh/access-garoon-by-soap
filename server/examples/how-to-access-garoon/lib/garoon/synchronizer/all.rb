module Garoon
  module Synchronizer
    class All
      def initialize(client)
        @bulletin = Garoon::Synchronizer::Bulletin.new(client)
      end

      def run
        @bulletin.run
      end
    end
  end
end
