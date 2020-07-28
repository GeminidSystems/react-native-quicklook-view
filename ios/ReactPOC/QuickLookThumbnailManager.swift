//
//  QuickLookThumbnailManager.swift
//  ReactPOC
//
//  Created by Geoffrey Xue on 7/27/20.
//

import Foundation


@objc(QuickLookThumbnailManager)
class QuickLookThumbnailManager : RCTViewManager {
  
  override static func requiresMainQueueSetup() -> Bool {
      return true
  }
  
  override func view() -> UIView! {
    return QuickLookThumbnail()
  }

}
