module Celestial
  # The connection between a client and a `Celestial::Server`
  class Server
    class Connection
      def initialize(@socket : HTTP::WebSocket)
      end

      def name
        "a connection"
      end

      def socket
        @socket
      end

      def send(message)
        @socket.send message
      end
    end
  end
end
