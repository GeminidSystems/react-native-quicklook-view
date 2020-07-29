//
//  QuickLook.swift
//  POCApp
//
//  Created by Geoffrey Xue on 7/21/20.
//

import Foundation
import QuickLook


class QuickLookView : UIView, QLPreviewControllerDataSource, QLPreviewControllerDelegate {

  private var previewView: UIView?
  private var controller: QLPreviewController?
  @objc var fileSource: NSNumber = -1
  @objc var urlString: NSString = ""
  @objc var fileData: NSString = ""
  @objc var fileType: NSString = ""
  @objc var fileID: NSNumber = -1

  
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
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return 1
  }
  
  func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    print("Generated preview in view")
    /*
    Util.getFile(fileSource: FileSource(rawValue: Int(truncating: fileSource))!,
                    urlString: urlString,
                    fileData: fileData, fileType: fileType,
                    fileID: fileID) { (success: Bool, fileLocation: URL?) in
  */

    let url = Bundle.main.url(forResource: urlString as String, withExtension: nil)
    if (url == nil) {
      print("No URL found for \(urlString)")
      return Bundle.main.url(forResource: "noURL.png", withExtension: nil)! as QLPreviewItem
    }
    
    return url! as QLPreviewItem
  }
}
