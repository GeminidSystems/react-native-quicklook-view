//
//  QuickLookViewManager.swift
//  POCApp
//
//  Created by Geoffrey Xue on 7/22/20.
//

import Foundation


@objc(QuickLookViewManager)
class QuickLookViewManager : RCTViewManager {
  
  override static func requiresMainQueueSetup() -> Bool {
      return true
  }
  
  override func view() -> UIView! {
    return QuickLookView()
  }

}
