//
//  ActionableEventSetTests.swift
//  Actionable
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableEventSetTests: XCTestCase {

   func testAddHandlerSingle() {
      let eventSet = ActionableEventSet()
      XCTAssertEqual(0, eventSet.handlerCount())
      eventSet.addHandler({ _ in })
      XCTAssertEqual(1, eventSet.handlerCount())
   }

   func testAddHandlerMultiple() {
      let eventSet = ActionableEventSet()
      XCTAssertEqual(0, eventSet.handlerCount())
      eventSet.addHandler({ _ in })
      eventSet.addHandler({ _ in })
      XCTAssertEqual(2, eventSet.handlerCount())
   }

   func testRemoveSingle() {
      let eventSet = ActionableEventSet()
      let event = eventSet.addHandler({ _ in })
      eventSet.removeHandler(event)
      XCTAssertEqual(0, eventSet.handlerCount())
   }

   func testRemoveMultiple() {
      let eventSet = ActionableEventSet()
      let eventA = eventSet.addHandler({ _ in })
      let eventB = eventSet.addHandler({ _ in })
      eventSet.removeHandler(eventA)
      XCTAssertEqual(1, eventSet.handlerCount())
      eventSet.removeHandler(eventB)
      XCTAssertEqual(0, eventSet.handlerCount())
   }

   func testRemoveMultipleRemoves() {
      let eventSet = ActionableEventSet()
      let eventA = eventSet.addHandler({ _ in })
      eventSet.addHandler({ _ in })
      eventSet.removeHandler(eventA)
      eventSet.removeHandler(eventA)
      eventSet.removeHandler(eventA)
      XCTAssertEqual(1, eventSet.handlerCount())
   }
   
}
