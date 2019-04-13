module Celestial
  # The connection between a client and a `Celestial::Server`
  class Server
    class Connection
      getter socket

      def initialize(@socket : HTTP::WebSocket)
      end

      # TODO: Implement auth, usernames, etc.
      def name
        "a connection"
      end

      def send(message)
        @socket.send message
      end
    end
  end
end
