module Celestial
  class Server
    # TODO: Figure out how this should work
    class Response
      def initialize(@yaml : String? = nil)
      end

      def to_yaml
        @yaml
      end
    end
  end
end
