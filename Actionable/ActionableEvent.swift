//
//  ActionableEvent.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class ActionableEvent {
   var events: [ActionableHandler] = []

   /**
    * Adds the handler wrapper to the list of handlers.
    *
    * - parameter wrapper: The wrapper for the closure
    */
   func addHandler(wrapper: ActionableHandler) {
      events.append(wrapper)
   }

   /**
    * Remove the handler with the given wrapper
    *
    * - parameter wrapper: The wrapper for the handler
    */
   func removeHandler(wrapper: ActionableHandler) {
      for (index, event) in events.enumerate() {
         if event === wrapper {
            events.removeAtIndex(index)
         }
      }
   }

   /**
    * Will call all the handlers currently stored
    */
   func callAllHandlers(data: Any?) {
      for event in events {
         event.call(data)
      }
   }

   /**
    * Will call all the handlers sequentially waiting
    * for each to finish before calling next. Will call
    * `completed` when all done.
    */
   func callHandlersSequentially(data: Any?, completed: () -> Void) {
      callNextHandler(events, withData: data, completed: completed)
   }

   /**
    * Used for calling the handlers from `callHandlersSequentially(data: completed:)`
    */
   private func callNextHandler(handlers: [ActionableHandler], withData data: Any?, completed: () -> Void) {
      if handlers.count <= 0 {
         // No handlers left to call. All done.
         completed()
         return
      }

      var mutableHandlers = handlers
      let first = mutableHandlers.removeAtIndex(0)  // Pop first element from list
      first.call(data) { () -> Void in
         self.callNextHandler(mutableHandlers, withData: data, completed: completed)
      }
   }

   /**
    * Returns the number of handlers stored
    *
    * - returns: Total handler count
    */
   func handlerCount() -> Int {
      return events.count
   }

}
