//
//  ActionablePerformanceTests.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionablePerformanceTests: XCTestCase {
   let LoopCount = 50000

   func testBasicClosure() {
      var index = 0
      let closure: () -> Void = {
         index += 1
      }

      measureBlock() {
         for i in 0...self.LoopCount {
            closure()
         }
      }
   }

   func testActionable() {
      var index = 0
      let closure: (Any?) -> Void = { _ in
         index += 1
      }

      let actionable = Actionable()
      actionable.on("increment", handler: closure)

      measureBlock() {
         for i in 0...self.LoopCount {
            actionable.trigger("increment")
         }
      }
   }

   func testActionableEventSet() {
      var index = 0
      let closure: (Any?) -> Void = { _ in
         index += 1
      }

      let eventSet = ActionableEvent()
      eventSet.addHandler(ActionableHandler(closure))

      measureBlock() {
         for i in 0...self.LoopCount {
            eventSet.callAllHandlers(nil)
         }
      }
   }

   func testActionableEvent() {
      var index = 0
      let closure: (Any?) -> Void = { _ in
         index += 1
      }

      let event = ActionableHandler(closure)

      measureBlock() {
         for i in 0...self.LoopCount {
            event.call()
         }
      }
   }

}
