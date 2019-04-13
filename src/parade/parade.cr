require "../server/request"
require "./*"

module Celestial
  # The part of Celestial that handles the world and config
  class Parade
    # Create a Parade
    def initialize(@world = World.new)
    end

    # Query the Parade
    def query(request : Server::Request)
      case request.type
      when .state_full?   then state_full
      when .last_changed? then last_changed
      when .change?       then change(request)
      else
        Error::SyntaxError.new("invalid request type").to_response
      end
    rescue e : Parade::Error
      return e.to_response
    end

    def query(string : String)
      query Server::Request.new(string)
    end

    private def state_full
      Server::Response.new({
        type:  :success,
        state: @world,
      })
    end

    private def last_changed
      Server::Response.new({
        type: :success,
        time: @world.timestamp,
      })
    end

    private def change(diff : Diff) : Server::Response
      @world.apply! diff
      last_changed
    end
  end
end
