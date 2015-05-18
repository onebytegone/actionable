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

   func on(event: String, handler: () -> Void) {
      fatalError("on(event:, handler:) has not been created yet")
   }

   func off(event: String, handler: () -> Void = { _ in }) {
      fatalError("off(event:, handler:) has not been created yet")
   }

   func trigger(event: String) {
      fatalError("trigger(event:) has not been created yet")
   }
}