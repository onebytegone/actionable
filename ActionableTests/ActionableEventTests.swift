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

   func testAddHandlerSingle() {
      let eventSet = ActionableEvent()
      XCTAssertEqual(0, eventSet.handlerCount())
      let handler = ActionableHandler({ _ in })
      eventSet.addHandler(handler)
      XCTAssertEqual(1, eventSet.handlerCount())
   }

   func testAddHandlerMultiple() {
      let eventSet = ActionableEvent()
      XCTAssertEqual(0, eventSet.handlerCount())
      let handler = ActionableHandler({ _ in })
      eventSet.addHandler(handler)
      eventSet.addHandler(handler)
      XCTAssertEqual(2, eventSet.handlerCount())
   }

   func testRemoveSingle() {
      let eventSet = ActionableEvent()
      let handler = ActionableHandler({ _ in })
      eventSet.addHandler(handler)
      eventSet.removeHandler(handler)
      XCTAssertEqual(0, eventSet.handlerCount())
   }

   func testRemoveMultiple() {
      let eventSet = ActionableEvent()
      let handlerA = ActionableHandler({ _ in })
      let handlerB = ActionableHandler({ _ in })
      eventSet.addHandler(handlerA)
      eventSet.addHandler(handlerB)
      XCTAssertEqual(2, eventSet.handlerCount())
      eventSet.removeHandler(handlerA)
      XCTAssertEqual(1, eventSet.handlerCount())
      eventSet.removeHandler(handlerB)
      XCTAssertEqual(0, eventSet.handlerCount())
   }

// TODO: Make this work. Currently this breaks the code
//   func testRemoveMultipleOfSame() {
//      let eventSet = ActionableEvent()
//      let handler = ActionableHandler({ _ in })
//      eventSet.addHandler(handler)
//      eventSet.addHandler(handler)
//      XCTAssertEqual(2, eventSet.handlerCount())
//      eventSet.removeHandler(handler)
//      XCTAssertEqual(0, eventSet.handlerCount())
//   }

   func testRemoveMultipleRemoves() {
      let eventSet = ActionableEvent()
      let handlerA = ActionableHandler({ _ in })
      let handlerB = ActionableHandler({ _ in })
      eventSet.addHandler(handlerA)
      eventSet.addHandler(handlerB)
      eventSet.removeHandler(handlerA)
      eventSet.removeHandler(handlerA)
      eventSet.removeHandler(handlerA)
      XCTAssertEqual(1, eventSet.handlerCount())
   }

}
