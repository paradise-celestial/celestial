module Celestial
  class Parade
    # A `Vessel` is the base unit of the Paradise world. Vessels have names,
    # optional attributes, parents, owners, and triggers.
    class Vessel
      enum Operation
        SET; UNSET; EDIT
      end

      property parent,
        name,
        owner,
        attr,
        note,
        triggers

      def initialize(@parent,
                     @name,
                     @owner = -1,
                     @attr = "",
                     @note = "",
                     @triggers = {} of Symbol => String)
      end

      # Apply the given *diff*, returning `true` on success and a reason on
      # failure.
      #
      # TODO: Implement failure conditions
      def apply(diff : VesselDiff) : Bool | String
        @name = diff.name || @name
        @attr = diff.attr || @attr
        @note = diff.note || @note

        @parent = diff.parent || @parent
        @owner  = diff.owner  || @owner

        @triggers = diff.triggers || @triggers

        true
      end

      # Apply the given *diff*, returning `true` on success and raising an
      # exception on failure.
      def apply!(diff : VesselDiff) : Bool
        result = apply diff
        if result.is_a? String
          raise Error::Forbidden.new(result)
        end
        result
      end

      YAML.mapping(
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
end
