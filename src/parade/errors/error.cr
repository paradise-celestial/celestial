module Celestial
  class Parade
    # An error raised by the `Parade`. These errors indicate that, for some
    # reasin, a `Request` could not be fulfilled.
    class Error < StandardError
      def to_json
        {
          type:     :failure,
          response: :server_error,
        }.to_json
      end

      class Forbidden
        def to_json
          {
            type:     :failure,
            response: :forbidden,
          }.to_json
        end
      end
    end
  end
end
