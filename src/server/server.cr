require "http/server"
require "logger"

require "../config"
require "./*"

module Celestial
  # A Celestial websocket server
  class Server
    @connections = [] of Connection

    # Create a new server with a given *config* (see `Config`) and *URI*.
    #
    # Use as such:
    # ```
    # data = File.open("path/to/config.yml") do |file|
    #   YAML.parse file
    # end
    # config = Celestial::Config.new data
    # server = Celestial::Server.new config
    # server.start
    # ```
    def initialize(@parade : Parade, @uri : URI = URI.parse("ws://0.0.0.0:80"), @log : Logger = Logger.new(STDOUT), log_level : Logger::Severity? = nil)
      @log.level = log_level if log_level
    end

    # Starts the server. Blocks until the server is closed.
    # TODO: Send response to other sockets as well
    def start
      socket_handler = HTTP::WebSocketHandler.new do |socket|
        connection = Connection.new socket
        @connections << connection

        @log.info "Socket connected"

        socket.on_message do |message|
          @log.info "Recieved query from #{connection.name}: '#{request}'"
          response = @parade.query message

          connection.send response.to_send
        end

        socket.on_close do
          puts "Socket disconnection" if @debug_level == :verbose
          @connections.delete connection
        end
      end

      server = HTTP::Server.new [socket_handler]
      address = server.bind_tcp (@uri.host || "0.0.0.0"), (@uri.port || 80)
      puts "Binding to ws://#{address}"
      server.listen
    end
  end
end
