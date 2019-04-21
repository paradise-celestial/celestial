require "yaml"

module Celestial
  # Defines the world. A world contains many `Vessel` objects, and has a
  # `timestamp` (in UTC) when it was last touched.
  class World
    @on_change : Proc(Hash(Symbol, Int32), Nil)?

    def initialize(@vessels = [] of Vessel, @timestamp = Time.utc_now)
    end

    def []?(id)
      @vessels[id]?
    end

    def [](id)
      @vessels[id]
    end

    # Remove a vessel from the world, shifting down all indexes after it and
    # removing references to it.
    #
    # FIXME: Make a vessel's children spill into its parent when the vessel is deleted
    def delete(id)
      @vessels.delete self[id]
      (0...@vessels.size).each do |v_id|
        v = self[v_id]
        # Decrement parents / orphan vessels as needed
        v.parent -= 1 if v.parent > id
        v.parent = v_id if v.parent == id
        # Decrement owners / disown vessels as needed
        v.owner -= 1 if v.owner > id
        v.owner = v_id if v.owner == id
      end
    end

    def touch
      @timestamp = Time.utc_now
    end

    def index(env)
      env.response.content_type = "application/json"
      to_json
    end

    def get(id, env)
      if @vessels[id]?
        env.response.content_type = "application/json"
        @vessels[id].to_json
      else
        env.response.status = HTTP::Status::NOT_FOUND
        nil
      end
    end

    def post(env)
      @vessels << Vessel.new(
        name: param(name, String),
        parent: param(parent, Int64),
        attr: param?(attr, String) || "",
        note: param?(note, String) || "",
        owner: param?(owner, Int64) || -1,
        triggers: param?(triggers, Hash(String, String)) || {} of String => String
      )

      change_made({:post => @vessels.size})

      env.response.content_type = "application/json"
      {
        type:      "success",
        id:        @vessels.size,
        timestamp: @timestamp,
      }.to_json
    end

    def patch(id, env)
      if @vessels[id]?
        set_param name, String
        set_param parent, Int64
        set_param attr, String
        set_param note, String
        set_param owner, Int64
        set_param triggers, Hash(String, String)
      else
        env.response.status = HTTP::Status::NOT_FOUND
        nil
      end
      change_made({:patch => id})
      env.response.content_type = "application/json"
      {
        type:      "success",
        timestamp: @timestamp,
      }.to_json
    end

    def delete(id, env)
      if @vessels[id]?
        delete id
        change_made({:delete => id})
        env.response.content_type = "application/json"
        {
          type:      "success",
          timestamp: @timestamp,
        }.to_json
      else
        env.response.status = HTTP::Status::NOT_FOUND
        nil
      end
    end

    def on_change(&@on_change : Hash(Symbol, Int32) ->)
    end

    private def change_made(msg) : Nil
      touch
      on_change = @on_change
      return if on_change.nil?
      on_change.call msg
    end

    private macro set_param(name, param_type)
      if param?({{name}}, {{param_type}})
        @vessels[id].{{ name.id }} = param({{name}}, {{param_type}})
      end
    end

    private macro param(name, param_type)
      env.params.json["{{ name.id }}"].as({{ param_type }})
    end

    private macro param?(name, param_type)
      env.params.json["{{ name.id }}"]?.as({{ param_type }}?)
    end

    JSON.mapping(
      vessels: Array(Vessel),
      timestamp: {type:    Time,
                  default: Time.utc_now}
    )
  end
end
