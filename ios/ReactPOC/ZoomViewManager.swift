//
//  ZoomViewManager.swift
//  
//
//  Created by Geoffrey Xue on 8/4/20.
//

import Foundation

@objc(ZoomViewManager)
class ZoomViewManager : RCTViewManager {
  
  var zoomView: ZoomView?
  
  override static func requiresMainQueueSetup() -> Bool {
      return true
  }
  
  override func view() -> UIView! {
    self.zoomView = ZoomView()
    return zoomView
  }
  
  func startMeetingViaManager() {
    zoomView!.startMeeting()
  }

}
