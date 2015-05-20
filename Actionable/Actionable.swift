
//
//  Actionable.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class Actionable {
   var eventStore: [String : ActionableEvent] = [:]

   public init() { }

   /**
    * Registers a handler for the specified event
    *
    * :param: event The key for the event handler
    * :param: closure The closure to run on event trigger
    */
   public func on(event: String, closure: (Any?) -> Void) -> ActionableHandler {
      var handler = ActionableHandler(closure)
      eventSetForEvent(event).addHandler(handler)
      return handler
   }

   /**
    * Fires the given event
    *
    * :param: event The key for the event handler
    */
   public func trigger(event: String, data: Any? = nil) {
      eventSetForEvent(event).callAllHandlers(data)
   }

   /**
    * Removes a handler for the specified event
    *
    * :param: event The key for the event handler
    * :param: wrapper The `ActionableEvent` that would run on event trigger
    */
   public func off(event: String, wrapper: ActionableHandler) {
      eventSetForEvent(event).removeHandler(wrapper)
   }

   /**
    * Removes all handlers for the specified event
    *
    * :param: event The key for the event handler
    */
   public func allOff(event: String) {
      // Dispose of the event set
      eventStore[event] = ActionableEvent()
   }

   /**
    * Returns the event set for the event. If the event
    * set doesn't exist, it will be created.
    *
    * :param: eventName The key for the event handler
    *
    * :returns: The `ActionableEvent` for the event key
    */
   private func eventSetForEvent(eventName: String) -> ActionableEvent {
      if let event = eventStore[eventName] {
         return event
      }

      // Create new ActionableEvent
      var eventSet = ActionableEvent()
      eventStore[eventName] = eventSet
      return eventSet
   }

}
