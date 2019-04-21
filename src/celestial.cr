require "kemal"
require "./parade/*"
require "./macros"
require "./version"

module Celestial
  class_property world

  @@world = Celestial::World.new([
    Celestial::Vessel.new("library", 0),
  ])
  @@sockets = [] of HTTP::WebSocket

  get "/vessels" do |env|
    @@world.index(env)
  end

  vessel_methods get, patch, delete

  vessels_method post

  ws "/socket" do |socket|
    @@sockets << socket
  end

  @@world.on_change do |msg|
    json = {type: "notify", change: msg}.to_json
    @@sockets.each do |socket|
      socket.send json
    end
  end

  Kemal.run
end
