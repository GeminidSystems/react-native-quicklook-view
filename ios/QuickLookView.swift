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
    private var previewURL: URL? = nil //URL = Bundle.main.url(forResource: "noURL.png", withExtension: nil)!
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
  @objc var fileID: NSString = "" {
    didSet {handleUpdate()}
  }

  override init(frame: CGRect) {

    super.init(frame: frame)
    print("Initing QuickLookView from Swift")


    previewView = UIView()
    controller = QLPreviewController()
    controller!.delegate = self
    controller!.dataSource = self
    previewView = controller!.view
    previewView!.autoresizingMask = [.flexibleWidth, .flexibleHeight ]
    controller!.view.backgroundColor = UIColor.black
    controller!.automaticallyAdjustsScrollViewInsets = false
    addSubview(previewView!)

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return 1
  }

  func handleUpdate() {
    //print("handled Update")
    //print(fileSource)
    //print(urlString)
    //print(fileData)
    //print(fileType)
    //print(fileID)

    if (fileSource == -1) {
      return
    }

    // TODO: Add try catch with this enum
    let source: FileSource = FileSource.init(rawValue: Int(truncating: fileSource))!
    switch (source) {
    case .Local:
      if (!(urlString as String).isEmpty && !(fileID as String).isEmpty) {
        generatePreviewView(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    case .Downloadable:
      if (!(urlString as String).isEmpty && !(fileID as String).isEmpty) {
        generatePreviewView(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    case .Main:
      if (!(urlString as String).isEmpty) {
        generatePreviewView(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    case .Base64:
      if (!(fileData as String).isEmpty && !(fileType as String).isEmpty && !(fileID as String).isEmpty) {
        generatePreviewView(fileSource: source, urlString: urlString, fileData: fileData, fileType: fileType, fileID: fileID)
      }
      break
    }
  }

  func generatePreviewView(fileSource: FileSource, urlString: NSString?, fileData: NSString?, fileType: NSString?, fileID: NSString?) {
    Util.getFile(fileSource: fileSource,
                 urlString: urlString,
                 fileData: fileData, fileType: fileType,
                 fileID: fileID) { (success: Bool, fileLocation: URL?) in

      if (success) {
        self.previewURL = fileLocation!
        self.controller!.refreshCurrentPreviewItem()
      }
    }
  }

  func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    return previewURL! as QLPreviewItem
  }
}
