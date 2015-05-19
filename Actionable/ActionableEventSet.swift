//
//  ActionableEventSet.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

class ActionableEventSet {
   var events: [ActionableEvent] = []

   /**
    * Adds the handler to the list of handlers. This will return 
    * an event wrapper for the handler. This wrapper should be
    * held onto if the specific handler needs to be removed 
    * later.
    *
    * :param: handler The closure to store
    *
    * :returns: A wrapper for the closure
    */
   func addHandler(handler: () -> Void) -> ActionableEvent {
      let event = ActionableEvent(handler: handler)
      events.append(event)
      return event
   }

   /** 
    * Remove the handler with the given wrapper
    *
    * :param: wrapper The wrapper for the handler
    */
   func removeHandler(wrapper: ActionableEvent) {
      for (index, event) in enumerate(events) {
         if event === wrapper {
            events.removeAtIndex(index)
         }
      }
   }

   /**
    * Will call all the handlers currently stored
    */
   func callAllHandlers() {
      for event in events {
         event.call()
      }
   }

   /**
    * Returns the number of handlers stored
    *
    * :returns: Total handler count
    */
   func handlerCount() -> Int {
      return events.count
   }
}