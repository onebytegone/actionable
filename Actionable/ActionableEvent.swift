//
//  ActionableEvent.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

class ActionableEvent {
   let handler: () -> Void

   /**
    * Setup
    *
    * :param: handler The closure to store which can be called later
    */
   init(handler: () -> Void) {
      self.handler = handler
   }

   /**
    * Runs the stored closure
    */
   func call() {
      handler()
   }
}