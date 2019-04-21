require "json"

module Celestial
  # A `Vessel` is the base unit of the Paradise world. Vessels have names,
  # optional attributes, parents, owners, and triggers.
  class Vessel
    def initialize(@name, parent, @attr = "", @note = "", owner = -1, @triggers = {} of String => String)
      @parent = parent.to_i32
      @owner  = owner.to_i32
    end

    def parent=(parent : Int64)
      @parent = parent.to_i32
    end

    def owner=(owner : Int64)
      @owner = owner.to_i32
    end

    JSON.mapping(
      name: String,
      attr: {
        type:    String,
        default: "",
      },
      note: {
        type:    String,
        default: "",
      },
      parent: Int32,
      owner: {
        type:    Int32,
        default: -1,
      },
      triggers: {
        type:    Hash(String, String),
        default: {} of String => String,
      }
    )
  end
end
