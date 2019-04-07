require "http/server"

require "../config"

require "./connection"

require "./request"
require "./response"

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
    #
    # TODO: Use `logger` utility
    def initialize(@parade : Parade, @uri : URI = URI.parse("ws://0.0.0.0:80"), @debug_level = :verbose)
      raise "Debug level must be :error, :warn, or :verbose" unless [:error, :warn, :verbose].includes? @debug_level
    end

    # Starts the server. Blocks until the server is closed.
    # TODO: Send response to other sockets as well
    def start
      socket_handler = HTTP::WebSocketHandler.new do |socket|
        connection = Connection.new socket
        @connections << connection

        puts "Socket connection" if @debug_level == :verbose

        socket.on_message do |message|
          request = Request.from_json message
          puts "Recieved query from #{connection.name}: '#{message}'" if @debug_level == :verbose
          response = @parade.query request

          connection.send response.to_json
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
