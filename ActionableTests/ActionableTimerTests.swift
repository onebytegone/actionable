//
//  ActionableTimerTests.swift
//  Actionable
//
//  Created by Ethan Smith on 6/16/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableTimerTests: XCTestCase {
   func testTimer() {
      let startTime = NSDate.timeIntervalSinceReferenceDate()

      let timer = ActionableTimer()

      let expectation = self.expectationWithDescription("timer should fire")

      timer.timerWithInterval(0.1, closure: {
         var calledAt: Double = NSDate.timeIntervalSinceReferenceDate()
         XCTAssertTrue(startTime <= calledAt-0.1)
         expectation.fulfill()
      })

      self.waitForExpectationsWithTimeout(1, handler: nil)
   }

   func testTimerWithData() {
      let startTime = NSDate.timeIntervalSinceReferenceDate()

      let timer = ActionableTimer()

      let expectation = self.expectationWithDescription("timer should fire")

      timer.timerWithInterval(0.1, closure: { (data: Any?) in
         var calledAt: Double = NSDate.timeIntervalSinceReferenceDate()
         XCTAssertTrue(startTime <= calledAt-0.1)
         XCTAssertEqual("data!", data as! String)
         expectation.fulfill()
      }, data: "data!")

      self.waitForExpectationsWithTimeout(1, handler: nil)
   }

   func testLifecycle() {
      var fireACount = 0
      var fireBCount = 0

      let timer = ActionableTimer()

      let expectation = self.expectationWithDescription("timers should fire")

      timer.timerWithInterval(0.1, repeats: true, key: "A", closure: {
         fireACount += 1

         XCTAssertEqual(1, fireACount)
         XCTAssertEqual(0, fireBCount)

         timer.cancelTimer("A")

         timer.timerWithInterval(0.1, repeats: true, key: "B", closure: {
            fireBCount += 1

            XCTAssertEqual(1, fireACount)
            XCTAssertEqual(1, fireBCount)

            timer.cancelTimer("B")

            expectation.fulfill()
         })
      })

      self.waitForExpectationsWithTimeout(2, handler: nil)
   }

   func testRepeating() {
      var fireCount = 1
      var lastFireCount = 0

      let timer = ActionableTimer()

      let expectation = self.expectationWithDescription("repeat timer")

      timer.timerWithInterval(0.1, repeats: true, key: "A", closure: {
         fireCount += 1

         if fireCount > 5 {
            timer.cancelTimer("A")
            expectation.fulfill()
         }
      })

      self.waitForExpectationsWithTimeout(3, handler: nil)
   }

   func testTimerCleanup() {
      let timer = ActionableTimer()

      XCTAssertEqual(0, timer.numberOfStoredTimers())

      let expectation = self.expectationWithDescription("repeat timer")

      timer.timerWithInterval(0.1, repeats: false, key: "A", closure: {
         expectation.fulfill()
      })

      self.waitForExpectationsWithTimeout(3, handler: { (error: NSError!) -> Void in
         XCTAssertEqual(0, timer.numberOfStoredTimers())
      })
   }
}
