module Celestial
  class Server
    class Request
      getter request,
        request_type,
        diff : String?

      def initialize(string : String)
        @request = parse string
        @request_type = RequestType.new(@request[:type].to_s)

        case @request_type
        when .state_full?, .last_changed?
          if @request.keys.size != 1
            raise Error::SyntaxError.new("invalid request format")
          end
        when .change?
          if @request.keys == [:type, :diff]
            raise Error::SyntaxError.new("invalid request format")
          end
          @diff = @request[:diff].to_s
        end
      end

      # TODO
      private def parse(string : String)
      end

      enum RequestType
        STATE_FULL; LAST_CHANGED; CHANGE
      end
    end
  end
end
