module Celestial
  class Server
    class Request
      # TODO: Build protocol
      YAML.mapping(
        request_type: String,
        message: String
      )
    end
  end
end
