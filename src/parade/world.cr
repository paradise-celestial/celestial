require "./vessel"

module Celestial
  class Parade
    class World
      # Create a new world
      def initialize
        @vessels = [] of Vessel
      end

      # Insert a vessel into the world
      def <<(vessel : Vessel)
        @vessels << vessel
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
    end
  end
end
