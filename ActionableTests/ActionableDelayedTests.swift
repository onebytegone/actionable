//
//  ActionableDelayedTests.swift
//  Actionable
//
//  Created by Ethan Smith on 6/15/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableDelayedTests: XCTestCase {
   func testDelayedTrigger() {
      let expectation = expectationWithDescription("should fire")

      let actionable = Actionable()
      let wrapper = actionable.on("myEvent", handler: {
         expectation.fulfill()
      })
      actionable.triggerAfterDelay(0.1, event: "myEvent")

      waitForExpectationsWithTimeout(1, handler: nil)
   }

   func testDelayedTriggerWithData() {
      let expectation = expectationWithDescription("should fire")

      let actionable = Actionable()
      let wrapper = actionable.on("myEvent", handler: { (data: Any?) in
         expectation.fulfill()
         XCTAssertEqual("abc", data as! String)
      })
      actionable.triggerAfterDelay(0.1, event: "myEvent", data: "abc")

      waitForExpectationsWithTimeout(1, handler: nil)
   }

   func testTriggerOnInterval() {
      var fireCount = 0

      let expectation = expectationWithDescription("should fire")

      let actionable = Actionable()
      let wrapper = actionable.on("myEvent", handler: {
         fireCount += 1

         if fireCount > 5 {
            actionable.cancelTrigger("myEvent")
            expectation.fulfill()
         }
      })
      actionable.triggerOnInterval(0.1, event: "myEvent")

      waitForExpectationsWithTimeout(3, handler: nil)
   }
}
