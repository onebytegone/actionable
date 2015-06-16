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

      timer.timerWithInterval(0.1, closure: {
         var calledAt: Double = NSDate.timeIntervalSinceReferenceDate()
         XCTAssertTrue(startTime <= calledAt-0.1)
      })
   }

   func testTimerWithData() {
      let startTime = NSDate.timeIntervalSinceReferenceDate()

      let timer = ActionableTimer()

      timer.timerWithInterval(0.1, closure: { (data: Any?) in
         var calledAt: Double = NSDate.timeIntervalSinceReferenceDate()
         XCTAssertTrue(startTime <= calledAt-0.1)
         XCTAssertEqual("data!", data as! String)
      }, data: "data!")
   }
}
