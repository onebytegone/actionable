//
//  ActionableHandler.swift
//  Actionable
//
//  Created by Ethan Smith on 5/19/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class ActionableHandler {
   let handler: (Any?, () -> Void) -> Void

   /**
    * Setup
    *
    * - parameter handler: The closure to store which can be called later
    */
   public init(_ handler: (Any?) -> Void) {
      self.handler = { (data: Any?, next: () -> Void) in
         handler(data)
         next()
      }
   }

   /**
    * Setup
    *
    * - parameter handler: The closure to store which can be called later
    */
   public init(_ handler: (Any?, () -> Void) -> Void) {
      self.handler = handler
   }

   /**
    * Runs the stored closure
    */
   public func call(data: Any? = nil, next: () -> Void = { _ in }) {
      handler(data, next)
   }

}
