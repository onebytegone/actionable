# Actionable
An event hander system for Swift.

After many headaches and much spaghetti code to handle event handling, Actionable was created. The built in options of protocols, delegates, and closures become complicated when multiple objects need to be updated when an event occurs. NSNotificationCenter was a possible option, but it never quite seem to fit well.



## Status

This is a work in progress. It is in a pre alpha state.



## Usage

### `.on(key, handler)`

This is used to bind an action to the given event. The event is named with `key`. The closure `handler` will be called when that event is triggered.

```
let actionable = Actionable()
actionable.on("showGreeting", closure: { _ in
   println("Greetings and salutations!");
})
```

### `.allOff(key)`

This is used to remove all the handlers for the given event.

```
let actionable = Actionable()
actionable.allOff("showGreeting")
```

### `.off(key, wrapper)`

This is used to remove a specific handlers for the given event.

```
let actionable = Actionable()
var wrapper = actionable.on("showGreeting", closure: { _ in })
actionable.off("showGreeting", wrapper: wrapper)
```

### `.trigger(key)`

This is executes all the registered handlers for the event.

```
let actionable = Actionable()
actionable.trigger("showGreeting")
```
