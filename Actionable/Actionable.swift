
//
//  Actionable.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public protocol ActionableObject {
   var events: Actionable {get}
}

public class Actionable {
   var eventStore: [String : ActionableEvent] = [:]
   var timer: ActionableTimer = ActionableTimer()

   public init() { }

   // *****
   // MARK: Event Registration
   // *****

   /**
    * Registers a handler without any args for the specified event.
    *
    * - parameter event: The key for the event handler
    * - parameter handler: The closure to run on event trigger
    */
   public func on(event: String, handler: () -> Void) -> ActionableHandler {
      // Since the handler passed doesn't take any args,
      // we are going to wrap it with one that does.
      let wrapper = { ( arg: Any? ) in handler() }

      return self.on(event, handler: wrapper)
   }

   /**
    * Registers a handler for the specified event
    *
    * - parameter event: The key for the event handler
    * - parameter handler: The closure to run on event trigger
    */
   public func on(event: String, handler closure: (Any?) -> Void) -> ActionableHandler {
      let handler = ActionableHandler(closure)
      eventSetForEvent(event).addHandler(handler)
      return handler
   }

   /**
    * Registers a handler for the specified event
    *
    * - parameter event: The key for the event handler
    * - parameter handler: The closure to run on event trigger
    */
   public func on(event: String, handler closure: (Any?, () -> Void) -> Void) -> ActionableHandler {
      let handler = ActionableHandler(closure)
      eventSetForEvent(event).addHandler(handler)
      return handler
   }

   // *****
   // MARK: Event Triggering
   // *****

   /**
    * Fires the given event
    *
    * - parameter event: The key for the event handler
    */
   public func trigger(event: String, data: Any? = nil) {
      eventSetForEvent(event).callAllHandlers(data)
   }

   /**
    * Fires the given event, calling all the handlers
    * sequentially, waiting for each to finish before
    * calling the next. This is helpful when the event
    * handlers may have aync actions that need to be
    * waited on.
    *
    * - parameter event: The key for the event handler
    * - parameter data: The data to pass
    * - parameter completed: The completion callback
    */
   public func trigger(event: String, data: Any? = nil, completed: () -> Void) {
      eventSetForEvent(event).callHandlersSequentially(data, completed: completed)
   }

   // *****
   // MARK: Trigger Based on Time
   // *****

   /**
    * Fires the given event after a delay
    *
    * - parameter delay: The time, in seconds, to wait before triggering the event
    * - parameter event: The key for the event handler
    * - parameter data: Any data to pass to the event
    */
   public func triggerAfterDelay(delay: Double, event: String, data: Any? = nil) {
      timer.timerWithInterval(delay, repeats: false) { () -> Void in
         self.trigger(event, data: data)
      }
   }

   /**
    * Fires the given event after an interval, repeating at that interval.
    * If this is called twice for the same event, it will be called on the
    * last interval. e.g. called with 30sec interval, then called with 10sec
    * interval, the event will be repeated on a 10sec interval.
    *
    * - parameter interval: The time period, in seconds, to trigger the event on
    * - parameter event: The key for the event handler
    * - parameter data: Any data to pass to the event
    */
   public func triggerOnInterval(interval: Double, event: String, data: Any? = nil) {
      timer.timerWithInterval(interval, repeats: true, key: event) { () -> Void in
         self.trigger(event, data: data)
      }
   }

   // *****
   // MARK: Remove Temporal Events
   // *****

   /**
    * Removes the delayed or recurring triggers for the event
    *
    * - parameter event: The key for the event handler
    */
   public func cancelTrigger(event: String) {
      timer.cancelTimer(event)
   }

   /**
    * Removes any delayed or recurring triggers for the event
    */
   public func cancelAllTriggers() {
      timer.disposeOfStoredTimers()
   }

   // *****
   // MARK: Remove Event Handlers
   // *****

   /**
    * Removes a handler for the specified event
    *
    * - parameter event: The key for the event handler
    * - parameter wrapper: The `ActionableEvent` that would run on event trigger
    */
   public func off(event: String, wrapper: ActionableHandler) {
      eventSetForEvent(event).removeHandler(wrapper)
   }

   /**
    * Removes all handlers for the specified event
    *
    * - parameter event: The key for the event handler
    */
   public func allOff(event: String) {
      // Dispose of the event set
      eventStore[event] = ActionableEvent()
   }

   // *****
   // MARK: Additional Actions
   // *****

   /**
    * Adds the event `finalEvent` so it will be triggered when
    * the event named `initialEvent` on `target` is triggered.
    *
    * :Basic flow on trigger:
    *    1. `target` has trigger called for `initialEvent`
    *    2. `target` calls all its handlers
    *    3. One of the handlers triggers `finalEvent` on this object
    *
    * - parameter finalEvent: The name of the event to trigger
    * - parameter target: Another Actionable object that will triggers the event to act on
    * - parameter initialEvent: The event on `target` that starts the chain
    */
   public func chain(finalEvent: String, to target: Actionable, forEvent initialEvent: String) {
      target.on(initialEvent) { (data: Any?) -> Void in
         self.trigger(finalEvent, data: data)
      }
   }

   // *****
   // MARK: Helper Functions
   // *****

   /**
    * Returns the event set for the event. If the event
    * set doesn't exist, it will be created.
    *
    * - parameter eventName: The key for the event handler
    *
    * - returns: The `ActionableEvent` for the event key
    */
   private func eventSetForEvent(eventName: String) -> ActionableEvent {
      if let event = eventStore[eventName] {
         return event
      }

      // Create new ActionableEvent
      let eventSet = ActionableEvent()
      eventStore[eventName] = eventSet
      return eventSet
   }

}
