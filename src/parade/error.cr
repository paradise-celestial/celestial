module Celestial
  class Parade
    # An error raised by the `Parade`. These errors indicate that, for some
    # reason, a `Request` could not be fulfilled.
    class Error < Exception
      def to_yaml
        {
          type:     :failure,
          response: :server_error
        }.to_yaml
      end

      def to_response
        Celestial::Server::Response.new self.to_yaml
      end

      class Forbidden
        def to_yaml
          {
            type:     :failure,
            response: :forbidden,
            message:  message
          }.to_yaml
        end
      end
    end
  end
end
