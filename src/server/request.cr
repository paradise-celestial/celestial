require "json"

module Celestial
  class Server
    class Request
      # TODO: Build protocol
      JSON.mapping(
        request_type: String,
        message: String
      )
    end
  end
end
