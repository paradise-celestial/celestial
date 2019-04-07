module Celestial
  class Server
    class Response
      JSON.mapping(
        message: String
      )

      def initialize(@message : String)
      end
    end
  end
end
