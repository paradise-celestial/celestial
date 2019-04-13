require "../server/request"
require "./*"

module Celestial
  # The part of Celestial that handles the world and config
  class Parade
    # Create a Parade
    def initialize(@world = World.new)
    end

    # Query the Parade
    def query(request : Server::Request) : Server::Response
      Server::Response.new "TODO"
    end

    private def apply(diff : Diff) : Server::Response
      @world.apply! diff
      return Server::Response.new({

      })
    rescue Parade::Error => e
      return e.to_response
    end
  end
end
