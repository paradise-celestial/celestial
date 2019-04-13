require "yaml"

require "./server"
require "./parade"

# TODO: Write documentation for `Celestial`
module Celestial
  VERSION = "0.1.0"

  def self.start
    parade = Celestial::Parade.new
    server = Celestial::Server.new parade, URI.parse("ws://0.0.0.0:3000")
    server.start
  end
end

Celestial.start
