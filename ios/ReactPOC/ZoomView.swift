//
//  ZoomView.swift
//  ReactPOC
//
//  Created by Geoffrey Xue on 8/4/20.
//

import Foundation
import MobileRTC

class ZoomView : UIView, MobileRTCAuthDelegate {
  func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
      print(returnValue)
      print(MobileRTCAuthError_Success)
      if (returnValue != MobileRTCAuthError_Success)
      {
          let msg = "SDK authentication failed, error code: \(returnValue)"
          print(msg)
      }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    print("Initing QuickLookThumbnail from Swift")
    /*
    let mainSDK = MobileRTCSDKInitContext()
    mainSDK.domain = "zoom.us"
    MobileRTC.shared().initialize(mainSDK)
    let authService = MobileRTC.shared().getAuthService()
    print(MobileRTC.shared().mobileRTCVersion)
    authService?.delegate = self
    authService?.clientKey = "ROLEJt2ahn8HCxMREamw5XOxZuxqqH5FOHE7"
    authService?.clientSecret = "ZRRVVLjPRol7quhvgPEf3B9vRzgHBXQyaa1W"
    authService?.sdkAuth()
 */
    print(MobileRTC.shared())
    /*
    let text = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    text.text = "test from ios"
    addSubview(text)
 */
    let authService = MobileRTC.shared().getAuthService()
    authService?.login(withEmail: "xuegeo21@pewaukeeschools.org", password: "zoomPOC123", rememberMe: true);
  }
  
  @objc
  func startMeeting() {
    print("STARTING MEETING -------------------------------")
    let meetingSettings = MobileRTC.shared().getMeetingSettings()
    meetingSettings?.enableCustomMeeting = false
    meetingSettings?.meetingChatHidden = true
    let meetingService = MobileRTC.shared().getMeetingService()
    let params = MobileRTCMeetingStartParam4LoginlUser()
    params.noVideo = true
    let response = meetingService!.startMeeting(with: params)
    print("onStartMeeting, response: \(response)")
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
