//
//  ActionableTests.swift
//  ActionableTests
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableTests: XCTestCase {

   func testLifecycle() {
      var calledCount = 0;

      let actionable = Actionable()

      let wrapper = actionable.on("myEvent", handler: {
         calledCount += 1
      })

      actionable.trigger("otherEvent")
      XCTAssertEqual(0, calledCount)

      actionable.trigger("myEvent")
      XCTAssertEqual(1, calledCount)
      actionable.trigger("myEvent")
      XCTAssertEqual(2, calledCount)

      actionable.off("myEvent", wrapper: wrapper)
      actionable.trigger("myEvent")
      XCTAssertEqual(2, calledCount)
   }

}
