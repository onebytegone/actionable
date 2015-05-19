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
    * :param: wrapper The wrapper for the closure
    */
   func addHandler(wrapper: ActionableHandler) {
      events.append(wrapper)
   }

   /**
    * Remove the handler with the given wrapper
    *
    * :param: wrapper The wrapper for the handler
    */
   func removeHandler(wrapper: ActionableHandler) {
      for (index, event) in enumerate(events) {
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
         event.call(data: data)
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
