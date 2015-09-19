//
//  ActionableHandlerTests.swift
//  Actionable
//
//  Created by Ethan Smith on 5/19/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableHandlerTests: XCTestCase {

   func testLifecycle() {
      var calledCount = 0;

      let event = ActionableHandler({ _ in
         calledCount += 1
      })

      XCTAssertEqual(0, calledCount)
      event.call()
      XCTAssertEqual(1, calledCount)
      event.call()
      XCTAssertEqual(2, calledCount)
   }

   func testLifecycleWithArgs() {
      var calledCount = 0;

      let event = ActionableHandler({ (value: Any?) in
         calledCount += value as! Int
      })

      XCTAssertEqual(0, calledCount)
      event.call(5)
      XCTAssertEqual(5, calledCount)
      event.call(2)
      XCTAssertEqual(7, calledCount)
   }

   func testLifecycleWithNext() {
      var calledCount = 0,
          nextCalledCount = 0

      let event = ActionableHandler({ (value: Any?, next: () -> Void) in
         calledCount += value as! Int
         next()
      })

      XCTAssertEqual(0, calledCount)

      event.call(5, next: { () -> Void in
         nextCalledCount += 1
      })
      XCTAssertEqual(5, calledCount)
      XCTAssertEqual(1, nextCalledCount)

      event.call(2, next: { () -> Void in
         nextCalledCount -= 1
      })
      XCTAssertEqual(7, calledCount)
      XCTAssertEqual(0, nextCalledCount)
   }


   func testLifecycleWithAutoNext() {
      var calledCount = 0,
      nextCalledCount = 0

      let event = ActionableHandler({ (value: Any?) in
         calledCount += value as! Int
      })

      XCTAssertEqual(0, calledCount)

      event.call(5, next: { () -> Void in
         nextCalledCount += 1
      })
      XCTAssertEqual(5, calledCount)
      XCTAssertEqual(1, nextCalledCount)

      event.call(2, next: { () -> Void in
         nextCalledCount -= 1
      })
      XCTAssertEqual(7, calledCount)
      XCTAssertEqual(0, nextCalledCount)
   }

}
