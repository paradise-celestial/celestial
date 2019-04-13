module Celestial
  class Parade
    # A diff which can be applied to a `World`.
    class WorldDiff
      YAML.mapping(
        vessels: Hash(Int32, VesselDiff)
      )
    end

    # A diff which can be applied to a `Vessel`.
    class VesselDiff
      YAML.mapping(
        name: String?,
        attr: String?,
        note: String?,
        parent: Int32?,
        owner: Int32?,
        triggers: Hash(Symbol, String)?
      )
    end
  end
end
