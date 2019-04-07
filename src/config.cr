require "yaml"

module Celestial
  class Config
    # Create a new config given `YAML::Any`
    # TODO: Parse
    def initialize(@conf_string : YAML::Any)
    end

    def world : Array
      [] of String
    end
  end
end
