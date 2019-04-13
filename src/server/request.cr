module Celestial
  class Server
    class Request
      getter request : Hash(String, String),
        request_type : RequestType,
        diff : String?

      def initialize(string : String)
        @request = parse string
        request_type = RequestType.parse?(@request["type"].to_s)

        case request_type
        when .nil?
          raise Error::SyntaxError.new("invalid request type")
        when .state_full?, .last_changed?
          if @request.keys.size != 1
            raise Error::SyntaxError.new("invalid request format")
          end
        when .change?
          if @request.keys == ["type", "diff"]
            raise Error::SyntaxError.new("invalid request format")
          end
          @diff = @request["diff"].to_s
        else
          raise Error::SyntaxError.new("invalid request type")
        end

        @request_type = request_type
      end

      private def parse(string : String) : Hash(String, String)
        yaml = YAML.parse(string).as_h?
        raise Error::SyntaxError.new("invalid request type") unless yaml

        output = {} of String => String

        yaml.each do |k, v|
          raise Error::SyntaxError.new("invalid request type") if k.as_s?.nil? || v.as_s?.nil?
          output[k.as_s] = v.as_s
        end

        output
      end

      enum RequestType
        STATE_FULL; LAST_CHANGED; CHANGE
      end
    end
  end
end
