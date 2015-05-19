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
      event.call(data: 5)
      XCTAssertEqual(5, calledCount)
      event.call(data: 2)
      XCTAssertEqual(7, calledCount)
   }

}
