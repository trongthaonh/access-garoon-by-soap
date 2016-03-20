module Garoon
  module Synchronizer
    class All
      class << self
        def run
          Garoon::Synchronizer::Bulletin.run
        end
      end
    end
  end
end
