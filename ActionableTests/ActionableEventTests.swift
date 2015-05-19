//
//  ActionableEventTests.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableEventTests: XCTestCase {
   
   func testLifecycle() {
      var calledCount = 0;

      let event = ActionableEvent(handler: {
         calledCount += 1
      })

      XCTAssertEqual(0, calledCount)
      event.call()
      XCTAssertEqual(1, calledCount)
      event.call()
      XCTAssertEqual(2, calledCount)
   }
   
}
