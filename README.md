# Actionable
An event hander system for Swift.

After many headaches and much spaghetti code to handle event handling, Actionable was created. The built in options of protocols, delegates, and closures become complicated when multiple objects need to be updated when an event occurs. NSNotificationCenter was a possible option, but it never quite seem to fit well.



## Status

This is a work in progress. It is in a pre alpha state.



## Performance
Actionable is slower than using direct closures for event handling. Most of the slowdown seems to be the with dictionary lookups. It may be possible to speed it up, but for now it seems reasonable. There isn't much of an impact until an event is being fired repeatedly a few thousand times.  

#### Times for firing an event 50000 times back to back (Test is in the unit tests)
| Type                   | Avg. Time | % of baseline |
|------------------------|-----------|---------------|
| Closure (baseline)     | 0.04 sec  | 0%            |
| Actionable             | 0.134 sec | 335%          |
| Actionable w/o lookups | 0.047 sec | 117.5%        |



## Usage

### `.on(key, handler)`

This is used to bind an action to the given event. The event is named with `key`. The closure `handler` will be called when that event is triggered.

##### No Arguments:
```
let actionable = Actionable()
actionable.on("showGreeting", handler: {
   println("Greetings and salutations!");
})
actionable.trigger("showGreeting")
```

##### With Argument:
```
let actionable = Actionable()
actionable.on("showMsg", handler: { (msg: Any?) in
   println("Message is \(msg as! String)");
})
actionable.trigger("showMsg", data: "Hello")
actionable.trigger("showMsg", data: "Aloha")
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
var wrapper = actionable.on("showGreeting", handler: { })
actionable.off("showGreeting", wrapper: wrapper)
```

### `.trigger(key)`

This is executes all the registered handlers for the event.

```
let actionable = Actionable()
actionable.trigger("showGreeting")
```

### `.chain(key, target, event)`

This causes `key` to be triggered for this object when `event` on `target` is triggered. Chaining will pass given data along, even if some of the handlers do not require it.

```
let parent = Actionable()
let child = Actionable()

parent.on("increment") {
   println("increment called")
}

child.chain("moreadds", to: parent, forEvent: "increment");
child.on("moreadds") {
   println("Add more stuff!")
}

parent.trigger("increment")
```
