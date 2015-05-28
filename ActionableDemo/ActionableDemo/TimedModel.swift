//
//  TimedModel.swift
//  ActionableDemo
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import Foundation
import Actionable

class TimedModel : NSObject, ActionableObject {
   var events = Actionable();

   override init() {
      super.init()
      NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "timerFired", userInfo: nil, repeats: true)
   }

   func timerFired() {
      events.trigger("changed:timer")
   }
}
