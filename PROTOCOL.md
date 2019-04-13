# Celestial Protocol
<!-- REVIEW: Should we use JSON? -->
The Celestial protocol is implemented by passing JSON strings back and forth using WebSockets. The snippets below are in [CSON](https://github.com/bevry/cson) for readability. Uppercase strings are placeholders.

## Client Messages

### `r` Obtain the world's state in full

```cson
type: "state_full"
```

produces

```cson
type:  "success"
state: "STATE_STRING"
```

### `r` Obtain the time the world was last changed

```cson
type: "last_changed"
```

produces

```cson
type: "success"
time: "TIMESTAMP"
```

### `rw` Make a change

```cson
type: "change"
diff: "STATE_DIFF"
```

produces

```cson
type: "success"
time: "TIMESTAMP"
```

or

```cson
type:     "failure"
response: "FAILURE_TYPE"
message:  "MESSAGE" # optional
```

## Server Messages

### `r` Notify the client that a commit has taken place

```cson
type: "state_change"
diff: "STATE_DIFF"
```
