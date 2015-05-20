//
//  ActionableHandler.swift
//  Actionable
//
//  Created by Ethan Smith on 5/19/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class ActionableHandler {
   let handler: Any? -> Void

   /**
    * Setup
    *
    * :param: handler The closure to store which can be called later
    */
   public init(_ handler: (Any?) -> Void) {
      self.handler = handler
   }

   /**
    * Runs the stored closure
    */
   public func call(data: Any? = nil) {
      handler(data)
   }

}
