//
//  ActionableTimer.swift
//  Actionable
//
//  Created by Ethan Smith on 6/15/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation

public class ActionableTimer {
   private var timers: [String : NSTimer] = [:]

   deinit {
      disposeOfStoredTimers()
   }

   public func timerWithInterval(interval: NSTimeInterval, repeats: Bool = false, key: String? = nil, closure: () -> Void) {
      // Since the closure passed doesn't take any args,
      // we are going to wrap it with one that does.
      let wrapper = { ( arg: Any? ) in closure() }

      self.timerWithInterval(interval, repeats: repeats, key: key, closure: wrapper, data: nil)
   }

   public func timerWithInterval(interval: NSTimeInterval, repeats: Bool = false, key: String? = nil, closure: (Any?) -> Void, data: Any?) {
      let timer = NSTimer.scheduledTimerWithTimeInterval(
         interval,
         target: self,
         selector: "timerTriggered:",
         userInfo: TimerInfoPackage(closure: closure, data: data, repeating: repeats),
         repeats: repeats
      )
      storeTimer(timer, key: key)
   }

   public func cancelTimer(key: String) {
      timers[key]?.invalidate()
      timers[key] = nil
   }

   public func disposeOfStoredTimers() {
      // Cancel all timers
      for (key, timer) in timers {
         cancelTimer(key)
      }
   }

   @objc func timerTriggered(timer: NSTimer) {
      let package = timer.userInfo as! TimerInfoPackage

      // If the timer doesn't repeat, cancel it
      if !package.repeating {
         let keys = (timers as NSDictionary).allKeysForObject(timer) as! [String]
         map(keys) { (key: String) in
            self.cancelTimer(key)
         }
      }

      package.closure(package.data)
   }

   private func storeTimer(timer: NSTimer, key: String?) {
      let unwrappedKey = key ?? "\(NSDate.timeIntervalSinceReferenceDate())"

      // If a timer was already set for this key, kill it
      cancelTimer(unwrappedKey)

      timers[unwrappedKey] = timer
   }

   func numberOfStoredTimers() -> Int {
      return timers.count
   }
}

private class TimerInfoPackage {
   var closure: (Any?) -> Void = { _ in }
   var data: Any? = nil
   var repeating: Bool = false

   init(closure: (Any?) -> Void, data: Any?, repeating: Bool) {
      self.closure = closure
      self.data = data
      self.repeating = repeating
   }
}
