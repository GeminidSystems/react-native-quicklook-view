//
//  QuickLookViewManager.swift
//  POCApp
//
//  Created by Geoffrey Xue on 8/14/20.
//

import Foundation


@objc(QuickLookViewManager)
class QuickLookViewManager : RCTViewManager {
  
  var quicklookView: QuickLookView?
  
  override static func requiresMainQueueSetup() -> Bool {
      return true
  }
  
  override func view() -> UIView! {
    quicklookView = QuickLookView()
    return quicklookView
  }
  
  @objc(generatePreview:fileType:fileID:)
  func generatePreview(src: NSString, fileType: NSString, fileID: NSString) {
    DispatchQueue.main.async {
      self.quicklookView?.generatePreview(src: src, fileType: fileType, fileID: fileID)
    }
  }

}
