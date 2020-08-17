//
//  QuickLook.swift
//  POCApp
//
//  Created by Geoffrey Xue on 8/14/20.
//

import Foundation
import QuickLook


class QuickLookView : UIView, QLPreviewControllerDataSource, QLPreviewControllerDelegate {

  @objc var onTap: RCTDirectEventBlock?
  @objc var onPress: RCTDirectEventBlock?
  @objc var onFinishedLoading: RCTDirectEventBlock?
  private var previewView: UIView?
  private var controller: QLPreviewController?
  private var previewURL: URL = URL(fileURLWithPath: "")
  
  // file ID

  override init(frame: CGRect) {
    super.init(frame: frame)
    print("Initing QuickLookView from Swift")

    previewView = UIView()
    controller = QLPreviewController()
    controller!.delegate = self
    controller!.dataSource = self
    previewView = controller!.view
    previewView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(previewView!)
    
    self.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(sendTap(_:))));
    
    self.addGestureRecognizer(UILongPressGestureRecognizer(
      target: self,
      action: #selector(sendPress(_:))));
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
   func sendPress(_ gesture: UILongPressGestureRecognizer) {
     if gesture.state == .began {
       print("Pressed")
       if onPress != nil {
         onPress!(["view": self])
       }
     }
   }

  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return 1
  }
  
  func generatePreview(src: NSString, fileType: NSString?, fileID: NSString) {
    // fileID and src are required to generate a preview of a file
    if (fileID == "" || src == "") {
      self.handleError()
      return
    }
    
    // If the file is base64, a fileType is required
    if (!src.contains("https://") && !src.contains("file:///") && !src.contains("http://")) {
      if (fileType == nil) {
        self.handleError()
        return
      }
    }
    
    Util.getFile(fileID: fileID, src: src, fileType: fileType) { (success: Bool, fileLocation: URL?) in
      if (success) {
        self.previewURL = fileLocation!
        self.controller!.refreshCurrentPreviewItem()
      }
      else {
        self.handleError()
      }
      if self.onFinishedLoading != nil {
        self.onFinishedLoading!(["view": self])
      }
     }
  }
  
  func handleError() {
    print("Error handler called")
    //self.previewURL = Bundle.main.url(forResource: "noURL.png", withExtension: nil)!
    self.previewURL = URL(fileURLWithPath: "error")
    self.controller!.refreshCurrentPreviewItem()
  }
  
  func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    return previewURL as QLPreviewItem
  }
}
