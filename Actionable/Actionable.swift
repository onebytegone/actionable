//
//  Actionable.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

class Actionable {
   func printHello() {
      println("Hello")
   }

   /**
    * Registers a handler for the specified event
    *
    * :param: event The key for the event handler
    * :param: handler The closure to run on event trigger
    */
   func on(event: String, handler: () -> Void) {
      fatalError("on(event:, handler:) has not been created yet")
   }

   /**
    * Removes a handler for the specified event
    *
    * :param: event The key for the event handler
    * :param: handler The closure that should of ran on event trigger
    */
   func off(event: String, handler: () -> Void) {
      fatalError("off(event:, handler:) has not been created yet")
   }

   /**
    * Fires the given event
    *
    * :param: event The key for the event handler
    */
   func trigger(event: String) {
      fatalError("trigger(event:) has not been created yet")
   }
}