# Creates a REST verb for a vessel
#
# For example:
#
#     vessel_method get
#     # ==>
#     get "/vessels/:id" do |env|
#       id = env.params.url["id"].to_i32
#       world.http_get(id, env)
#     end
macro vessel_method(verb)
  {{ verb.id }} "/vessels/:id" do |env|
    id = env.params.url["id"].to_i32
    @@world.http_{{ verb.id }}(id, env)
  end
end

# Creates a REST verb for a vessel, not including ID
#
# For example:
#
#     vessels_method post
#     # ==>
#     post "/vessels" do |env|
#       world.http_post(env)
#     end
macro vessels_method(verb)
  {{ verb.id }} "/vessels" do |env|
    @@world.http_{{ verb.id }}(env)
  end
end

# Runs `#vessel_method` on all verbs given.
macro vessel_methods(*args)
  {% for verb, i in args %}
    vessel_method {{verb}}
  {% end %}
end

# Runs `#vessels_method` on all verbs given.
macro vessels_methods(*args)
  {% for verb, i in args %}
    vessels_method {{verb}}
  {% end %}
end
