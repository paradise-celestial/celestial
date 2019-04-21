# Celestial Protocol

The Celestial protocol is a simple REST API. The snippets below are in [CSON](https://github.com/bevry/cson) for readability. Response strings are the equivalent types.

## GET `/vessels`

```cson
timestamp: "Time" # Last edit in UTC
vessels:   "Array(Vessel)" # Array of Vessels - each equivalent to output of 'GET /vessels/:id' on that vessel
```

## GET `/vessels/:id`

```cson
name:     "String"
attr:     "String"
note:     "String"
parent:   "Int64"
owner:    "Int64"
triggers: "Hash(String, String)"
```

## POST `/vessels/:id`

```cson
name:     "String"
attr:     "String?"
note:     "String?"
parent:   "Int64"
owner:    "Int64?"
triggers: "Hash(String, String)?"
```

\-->

```cson
type:      "success",
id:        "Int32"
timestamp: "Time"
```

## PATCH `/vessels/:id`

```cson
name:     "String?"
attr:     "String?"
note:     "String?"
parent:   "Int64?"
owner:    "Int64?"
triggers: "Hash(String, String)?"
```

\-->

```cson
type:      "success",
timestamp: "Time"
```

## DELETE `/vessels/:id`

```cson
type:      "success",
timestamp: "Time"
```

# WebSockets

A client may also open a websocket to the server. The server will periodically send notifications to listening clients, following this format:

```cson
type: "notify"
change:
  "String": "Int64"
```

The contents of the `change` hash are the operation performed on the vessel, and the ID of that vessel.
