module Celestial
  class Server
    # TODO: Figure out how this should work
    class Response
      @yaml : String

      def initialize(contents)
        @yaml = contents.to_yaml
      end

      def to_send
        @yaml
      end
    end
  end
end
