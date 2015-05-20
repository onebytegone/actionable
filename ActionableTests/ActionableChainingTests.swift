//
//  ActionableChainingTests.swift
//  Actionable
//
//  Created by Ethan Smith on 5/20/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import XCTest

class ActionableChainingTests: XCTestCase {
   var parentCalledCount = 0,
       childCalledCount = 0,
       extraadd = 0

   var parent = Actionable(),
       child = Actionable(),
       dataparent = Actionable(),
       datachild = Actionable()

   override func setUp() {
      parentCalledCount = 0
      childCalledCount = 0
      extraadd = 0


      parent = Actionable()
      child = Actionable()

      parent.on("increment") {
         self.parentCalledCount += 1
      }

      parent.on("extraadd") {
         self.extraadd += 1
      }

      child.chain("moreadds", to: parent, forEvent: "increment");
      child.on("moreadds") {
         self.childCalledCount += 1
      }


      dataparent = Actionable()
      datachild = Actionable()

      dataparent.on("increment") { (value: Any?) in
         self.parentCalledCount += value as! Int
      }
      datachild.chain("moreadds", to: dataparent, forEvent: "increment");
      datachild.on("moreadds") { (value: Any?) in
         self.childCalledCount += value as! Int
      }


      // Data loss chain
      dataparent.on("dataloss") { (value: Any?) in
         self.parentCalledCount += value as! Int
      }

      parent.chain("losethatdata", to: dataparent, forEvent: "dataloss");
      parent.on("losethatdata") { }

      child.chain("losemoredata", to: parent, forEvent: "losethatdata");
      datachild.on("losemoredata") { }

      datachild.chain("lostdata", to: child, forEvent: "losemoredata");
      datachild.on("lostdata") { (value: Any?) in
         self.childCalledCount += value as! Int
      }
   }

   func testShouldntChain() {
      // Make sure other calls don't call the chained stuff
      parent.trigger("extraadd")
      XCTAssertEqual(1, extraadd)
      XCTAssertEqual(0, parentCalledCount)
      XCTAssertEqual(0, childCalledCount)
   }

   func testBasicChain() {
      parent.trigger("increment")
      XCTAssertEqual(0, extraadd)
      XCTAssertEqual(1, parentCalledCount)
      XCTAssertEqual(1, childCalledCount)
   }

   func testEndOfChain() {
      child.trigger("moreadds")
      XCTAssertEqual(0, extraadd)
      XCTAssertEqual(0, parentCalledCount)
      XCTAssertEqual(1, childCalledCount)
   }

   func testDataChain() {
      dataparent.trigger("increment", data: 20)
      XCTAssertEqual(20, parentCalledCount)
      XCTAssertEqual(20, childCalledCount)
   }

   func testDataLossChain() {
      // We shouldn't lose data, but let's make sure
      dataparent.trigger("dataloss", data: 20)
      XCTAssertEqual(20, parentCalledCount)
      XCTAssertEqual(20, childCalledCount)
   }

   func testStartingWithDataLossChain() {
      // We shouldn't lose data, but let's make sure
      parent.trigger("losethatdata", data: 20)
      XCTAssertEqual(0, parentCalledCount)
      XCTAssertEqual(20, childCalledCount)
   }

}