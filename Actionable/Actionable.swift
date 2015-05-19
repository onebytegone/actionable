
//
//  Actionable.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class Actionable {
   var eventStore: [String : ActionableEventSet] = [:]

   public init() {

   }

   /**
    * Registers a handler for the specified event
    *
    * :param: event The key for the event handler
    * :param: handler The closure to run on event trigger
    */
   public func on(event: String, handler: () -> Void) {
      eventSetForEvent(event).addHandler(handler)
   }

   /**
    * Removes all handlers for the specified event
    *
    * :param: event The key for the event handler
    */
   public func allOff(event: String) {
      // Dispose of the event set
      eventStore[event] = ActionableEventSet()
   }

   /**
    * Removes a handler for the specified event
    *
    * :param: event The key for the event handler
    * :param: handler The `ActionableEvent` that would run on event trigger
    */
   public func off(event: String, handler: ActionableEvent) {
      eventSetForEvent(event).removeHandler(handler)
   }

   /**
    * Fires the given event
    *
    * :param: event The key for the event handler
    */
   public func trigger(event: String) {
      eventStore[event]?.callAllHandlers()
   }

   /**
    * Returns the event set for the event. If the event 
    * set doesn't exist, it will be created.
    *
    * :param: event The key for the event handler
    *
    * :returns: The `ActionableEventSet` for the event key
    */
   private func eventSetForEvent(event: String) -> ActionableEventSet {
      if let eventSet = eventStore[event] {
         return eventSet
      }

      // Create new ActionableEventSet
      var eventSet = ActionableEventSet()
      eventStore[event] = eventSet
      return eventSet
   }
}
