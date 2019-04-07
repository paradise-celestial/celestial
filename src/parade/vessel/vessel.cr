require "json"

module Celestial
  class Parade
    # A `Vessel` is the base unit of the Paradise world. Vessels have names,
    # optional attributes, parents, owners, and triggers.
    class Vessel
      enum Operation
        SET; UNSET; EDIT
      end

      property parent, name, owner, attr, note, triggers

      def initialize(@parent : Int32,
                     @name : String,
                     @owner : Int32 = -1,
                     @attr = "",
                     @note = "",
                     @triggers = {} of Symbol => String)
      end
    end
  end
end
