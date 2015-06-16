//
//  ActionableTimer.swift
//  Actionable
//
//  Created by Ethan Smith on 6/15/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class ActionableTimer {
   public func timerWithInterval(interval: NSTimeInterval, repeats: Bool = false, closure: () -> Void) {
      // Since the closure passed doesn't take any args,
      // we are going to wrap it with one that does.
      let wrapper = { ( arg: Any? ) in closure() }

      return self.timerWithInterval(interval, repeats: repeats, closure: wrapper, data: nil)
   }

   public func timerWithInterval(interval: NSTimeInterval, repeats: Bool = false, closure: (Any?) -> Void, data: Any?) {
      let package: [String : Any?] = [
         "closure": closure,
         "data": data
      ]

      NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "timerTriggered", userInfo: package as? AnyObject, repeats: repeats);
   }

   private func timerTriggered(timer: NSTimer) {
      let package = timer.userInfo as! NSDictionary
      let closure = package["closure"] as! (Any?) -> Void
      let data: Any? = package["data"]

      closure(data)
   }
}
