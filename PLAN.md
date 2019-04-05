# Development Plan

Celestial is a server which runs Paradise. It has several design differences, but these are open to change. The following is a list of design ideas:

* Everything is a Vessel - The entire world is made of vessels.
* Actions, programs, and triggers are all methods on vessels. To parse an action:
  * Does the user's vessel have an applicable action?
  * Do any of the user's siblings have an applicable action?
  * Formats:
    * `verb` -> user vessel
    * `verb a/the vessel` -> other vessel
    * `verb a/the vessel into a/the other vessel` -> move/warp like action - first vessel
* Everything is a Lisp object
  * Actions are methods
  * Notes, name, attr, etc. are instance variables
* There are two types of action - server actions and client actions
  * Client actions are like `!disconnect` - they are implemented on the client and should have little to no impact on the server
* The connection between client and server is implemented with WebSockets.
