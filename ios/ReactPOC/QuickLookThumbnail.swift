//
//  QuickLookThumbnail.swift
//  ReactPOC
//
//  Created by Geoffrey Xue on 7/27/20.
//

import Foundation
import QuickLook

class QuickLookThumbnail : UIView {
  
  @objc var onTap: RCTDirectEventBlock?
  @objc var onLongPress: RCTDirectEventBlock?
  @objc var urlString = "" {
    didSet {
      print("urlString")
      generateThumbnailRepresentations(fileURL: urlString, local: true)
    }
  }
  @objc var test = "" {
    didSet {
      print("test")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    print("Initing QuickLookThumbnail from Swift")
    
    self.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(sendTap(_:))));
    
    self.addGestureRecognizer(UILongPressGestureRecognizer(
      target: self,
      action: #selector(sendLongPress(_:))));
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @objc
  func sendTap(_ gesture: UITapGestureRecognizer) {
    if gesture.state == .ended {
      if onTap != nil {
        onTap!(["view": self])
      }
    }
  }
  
  @objc
  func sendLongPress(_ gesture: UILongPressGestureRecognizer) {
    if gesture.state == .began {
      print("Long Pressed")
      if onLongPress != nil {
        onLongPress!(["view": self])
      }
    }
  }
  
  func generateThumbnailRepresentations(fileURL: String, local: Bool) {
    var url: URL?

    if (local) {
        url = Bundle.main.url(forResource: fileURL, withExtension: nil)
    }
    else {
        url = URL(fileURLWithPath: fileURL)
    }
    
    if (url == nil) {
        print("URL must be valid")
        return
    }
    
    let size: CGSize = CGSize(width: self.frame.width, height: self.frame.height)
    let scale = UIScreen.main.scale
    
    // Create the thumbnail request.
    if #available(iOS 13.0, *) {
      let request = QLThumbnailGenerator.Request(fileAt: url!,
                                                 size: size,
                                                 scale: scale,
                                                 representationTypes: .all)
      let generator = QLThumbnailGenerator.shared
      generator.generateRepresentations(for: request) { (thumbnail, type, error) in
          DispatchQueue.main.async {
              if thumbnail == nil || error != nil {
                  print("QLThumbnailGenerator failed to generate a thumbnail for picture")
                  print(error.debugDescription)
              } else {
                self.addSubview(UIImageView(image: thumbnail!.uiImage))
              }
          }
      }
    }
    else {
      // Fallback on earlier versions
    }
  }
}
