//
//  ActionableSequentialTests.swift
//  Actionable
//
//  Created by Ethan Smith on 5/29/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableSequentialTests: XCTestCase {
   var firstCalledCount = 0,
       secondCalledCount = 0,
       doneCalledCount = 0

   var actionable = Actionable()

   override func setUp() {
      firstCalledCount = 0
      secondCalledCount = 0

      actionable = Actionable()
   }

   func testSequentialNoNext() {
      actionable.on("call", handler: {
         self.firstCalledCount += 1
         XCTAssertEqual(0, self.secondCalledCount)
         XCTAssertEqual(0, self.doneCalledCount)
      })
      actionable.on("call", handler: {
         self.secondCalledCount += 1
         XCTAssertEqual(1, self.firstCalledCount)
         XCTAssertEqual(0, self.doneCalledCount)
      })

      actionable.trigger("call", completed: {
         self.doneCalledCount += 1
         XCTAssertEqual(1, self.firstCalledCount)
         XCTAssertEqual(1, self.secondCalledCount)
      })

      XCTAssertEqual(1, firstCalledCount)
      XCTAssertEqual(1, secondCalledCount)
      XCTAssertEqual(1, doneCalledCount)
   }

   func testSequentialManualNext() {
      actionable.on("call", handler: { (data, next) in
         XCTAssertEqual(0, self.secondCalledCount)
         XCTAssertEqual(0, self.doneCalledCount)

         next()

         self.firstCalledCount += 1
      })
      actionable.on("call", handler: {
         self.secondCalledCount += 1
         XCTAssertEqual(0, self.firstCalledCount)
         XCTAssertEqual(0, self.doneCalledCount)
      })

      actionable.trigger("call", completed: {
         self.doneCalledCount += 1
         XCTAssertEqual(0, self.firstCalledCount)
         XCTAssertEqual(1, self.secondCalledCount)
      })

      XCTAssertEqual(1, firstCalledCount)
      XCTAssertEqual(1, secondCalledCount)
      XCTAssertEqual(1, doneCalledCount)
   }
}
