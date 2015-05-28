//
//  ViewController.swift
//  ActionableDemo
//
//  Created by Ethan Smith on 5/18/15.
//  Copyright (c) 2015 Ethan Smith. All rights reserved.
//

import UIKit
import Actionable

class ViewController: UIViewController {
   var model = TimedModel()
   let label = UILabel()
   let toggleButton = UIButton()

   override func viewDidLoad() {
      super.viewDidLoad()

      toggleButton.setTitle("Turn on", forState: UIControlState.Normal)
      toggleButton.setTitle("Turn off", forState: UIControlState.Selected)
      toggleButton.backgroundColor = UIColor.lightGrayColor()
      toggleButton.addTarget(self, action: "toggleState:", forControlEvents: UIControlEvents.TouchUpInside)
      self.view.addSubview(toggleButton)

      label.text = "Press the button..."
      self.view.addSubview(label)
   }

   func toggleState(sender: UIButton) {
      if sender.selected {
         model.events.allOff("changed:timer")
      } else {
         model.events.on("changed:timer", handler: {
            self.label.text = "Date is \(NSDate.timeIntervalSinceReferenceDate())"
         });
      }

      sender.selected = !sender.selected;
   }

   override func viewDidLayoutSubviews() {
      label.frame = CGRectMake(30, 50, CGRectGetWidth(self.view.bounds)-60, 20)
      toggleButton.frame = CGRectMake(30, CGRectGetMaxY(label.frame)+20, CGRectGetWidth(self.view.bounds)-60, 50)
   }

}
