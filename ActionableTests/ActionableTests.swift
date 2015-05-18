//
//  ActionableTests.swift
//  ActionableTests
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import UIKit
import XCTest

class ActionableTests: XCTestCase {

   func testExample() {
      let actionable = Actionable()
      actionable.printHello()
   }

   func testLifecycle() {
      var calledCount = 0;

      let actionable = Actionable()

      actionable.on("myEvent", handler: {
         calledCount += 1
      })

      actionable.trigger("otherEvent")
      XCTAssertEqual(0, calledCount)

      actionable.trigger("myEvent")
      XCTAssertEqual(1, calledCount)
      actionable.trigger("myEvent")
      XCTAssertEqual(2, calledCount)
   }

}
