macro vessel_method(verb)
  {{ verb.id }} "/vessels/:id" do |env|
    id = env.params.url["id"].to_i32
    world.{{ verb.id }}(id, env)
  end
end

macro vessel_method_no_id(verb)
  {{ verb.id }} "/vessels" do |env|
    world.{{ verb.id }}(env)
  end
end

macro vessel_methods(*args)
  {% for verb, i in args %}
    vessel_method {{verb}}
  {% end %}
end

macro vessel_methods_no_id(*args)
  {% for verb, i in args %}
    vessel_method_no_id {{verb}}
  {% end %}
end
