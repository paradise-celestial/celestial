require "../server/request"

module Celestial
  # The part of Celestial that handles the world and config
  class Parade
    # Create a Parade
    def initialize
    end

    # Query the Parade
    def query(request : Server::Request) : Server::Response
      Server::Response.new "TODO"
    end
  end
end
