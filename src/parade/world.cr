module Celestial
  class Parade
    # Defines the world. A world contains many `Vessel` objects, and has a
    # `timestamp` (in UTC) when it was last touched. Any write interaction on
    # the world should also call the `#touch` method.
    class World
      property vessels, timestamp

      # Create a new world
      def initialize(@vessels = [] of Vessel, @timestamp = Time.utc_now)
      end

      # Insert a vessel into the world
      def <<(vessel : Vessel)
        @vessels << vessel
      end

      # Set the `timestamp` to the current UTC time.
      def touch
        @timestamp = Time.utc_now
      end

      # Remove a *vessel* from the world, shifting down all indexes after it and
      # removing references to it.
      def delete(vessel : Vessel)
        id = index(vessel).not_nil!
        @vessels.delete vessel
        @vessels.each do |v|
          # Decrement parents / orphan vessels as needed
          v.parent -= 1 if v.parent > id
          v.parent = index v if v.parent == id
          # Decrement owners / disown vessels as needed
          v.owner -= 1 if v.owner > id
          v.owner = index v if v.owner == id
        end
      end

      # Remove a vessel by its ID. See `#delete(vessel)`
      def delete(vessel_id : Int32)
        delete self[vessel_id]
      end

      # Obtain the ID of a given vessel
      def index(vessel : Vessel)
        @vessels.index vessel
      end

      # Obtain a vessel from its ID
      def [](id : Int)
        @vessels[id]
      end

      # Apply the given *diff* if doing so is allowed. Returns `true` on success
      # and a reason on faliure.
      def apply(diff : Diff) : Bool | String
        diff.vessels.each do |id, vessel_diff|
          result = self[id].apply vessel_diff
          return result if result.is_a? String
        end
        true
      end

      # Apply the given *diff* if doing so is allowed. Returns `true` on success
      # and raises an exception on failiure.
      def apply!(diff : Diff)
        diff.vessels.each do |id, vessel_diff|
          self[id].apply! vessel_diff
        end
        true
      end

      YAML.mapping(
        vessels: Array(Vessel),
        timestamp: {type:    Time,
                    default: Time.utf_now}
      )
    end
  end
end
