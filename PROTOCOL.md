# Celestial Protocol

The Celestial protocol is implemented by passing JSON strings back and forth using WebSockets. The snippets below are in [CSON](https://github.com/bevry/cson) for readability.

## Client Messages

### Obtain the world's state in full

```cson
type: "state_full"
```

produces

```cson
type: "success"
state: "STATE STRING"
```

### Obtain the world's state since a certain commit

```cson
type: "state_since"
when: "COMMIT ID"
```

produces

```cson
type: "success"
diff: "DIFF STRING"
```

or

```cson
type: "failure"
response: "FAILURE TYPE"
```

### Obtain the world's commit history

```cson
type: "commit"
```

produces

```cson
type: "success"
commits: [
  # Array of COMMIT IDs
]
```

or

```cson
type: "failure"
response: "FAILURE TYPE"
```

### Obtain details of any given commit

```cson
type: "commit"
when: "COMMIT ID"
```

produces

```cson
type: "success"
commit: {
  # Object representing the commit
}
```

or

```cson
type: "failure"
response: "FAILURE TYPE"
```

### Commit a new change

```cson
type: "commit"
diff: "STATE DIFF"
```

produces

```cson
type: "success"
commit: "COMMIT ID"
```

or

```cson
type: "failure"
response: "FAILURE TYPE"
```

## Server Messages

### Notify the client that a commit has taken place

```cson
type: "notify"
message: "state_change"
```

The client must not reply.
