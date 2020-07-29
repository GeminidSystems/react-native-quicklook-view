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
  @objc var fileSource: NSNumber = -1 {
     didSet {handleUpdate()}
  }
  @objc var urlString: NSString = "" {
    didSet {handleUpdate()}
  }
  @objc var fileData: NSString = "" {
     didSet {handleUpdate()}
  }
  @objc var fileType: NSString = "" {
    didSet {handleUpdate()}
  }
  @objc var fileID: NSNumber = -1 {
    didSet {handleUpdate()}
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
  
  func handleUpdate() {
    print("handled Update")
    print(fileSource)
    print(urlString)
    print(fileData)
    print(fileType)
    print(fileID)
    
    if (fileSource == -1) {
      return
    }
    
    // TODO: Add try catch with this enum
    let source: FileSource = FileSource.init(rawValue: Int(truncating: fileSource))!
    switch (source) {
    case .Local:
      if (!(urlString as String).isEmpty && fileID != -1) {
        generateThumbnailRepresentations(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    case .Downloadable:
      if (!(urlString as String).isEmpty && fileID != -1) {
        generateThumbnailRepresentations(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    case .Main:
      if (!(urlString as String).isEmpty) {
        generateThumbnailRepresentations(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    case .Base64:
      if (!(fileData as String).isEmpty && !(fileType as String).isEmpty && fileID != -1) {
        generateThumbnailRepresentations(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    }
  }
  
  func generateThumbnailRepresentations(fileSource: FileSource, urlString: NSString?, fileData: NSString?, fileType: NSString?, fileID: NSNumber?) {
    Util.getFile(fileSource: fileSource,
                 urlString: urlString,
                 fileData: fileData, fileType: fileType,
                 fileID: fileID) { (success: Bool, fileLocation: URL?) in
      
      if #available(iOS 13.0, *) {
        if (success) {
          let size: CGSize = CGSize(width: self.frame.width, height: self.frame.height)
          let scale = UIScreen.main.scale
        
          
          let request = QLThumbnailGenerator.Request(fileAt: fileLocation!,
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
      }
      else {
        // Fallback on earlier versions
      }
    }
  }
}
