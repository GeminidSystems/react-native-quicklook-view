//
//  Util.swift
//  ReactPOC
//
//  Created by Geoffrey Xue on 7/27/20.
//

import Foundation

enum FileType: Int {
    case Local
    case Download
    case Main
    case String
}


class Util {
  static func getFile(fileURL: NSString, fileType: NSNumber, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    let type: FileType = FileType(rawValue: Int(truncating: fileType))!
    switch (type) {
    case .Local:
      retrieveFile(fileURL: fileURL as String) { (_ success: Bool,_ fileLocation: URL?) in
        completion(success, fileLocation)
      }
    case .Download:
      downloadFile(fileURL: fileURL as String) { (_ success: Bool,_ fileLocation: URL?) in
        completion(success, fileLocation)
      }
    case .Main:
      getMainFile(fileURL: fileURL as String) { (_ success: Bool,_ fileLocation: URL?) in
        completion(success, fileLocation)
      }
    case .String:
      <#code#>
    }
  }
  
  static func retrieveFile(fileURL: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {

    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileURL.components(separatedBy: "/").last!)
    
    // to check if file exists
    if FileManager.default.fileExists(atPath: destinationUrl.path) {
      debugPrint("The file already exists at path")
      completion(true, destinationUrl)
    }
    else {
      completion(false, nil)
    }
  }
  
  static func downloadFile(fileURL: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
      
      let itemUrl = URL(string: fileURL)
      
      let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let destinationUrl = documentsDirectoryURL.appendingPathComponent(fileURL.components(separatedBy: "/").last!)
      
      // to check if it exists before downloading it
      if FileManager.default.fileExists(atPath: destinationUrl.path) {
          debugPrint("The file already exists at path")
          completion(true, destinationUrl)
          
      } else {
          // you can use NSURLSession.sharedSession to download the data asynchronously
          URLSession.shared.downloadTask(with: itemUrl!, completionHandler: { (location, response, error) -> Void in
              guard let tempLocation = location, error == nil else { return }
              do {
                  // after downloading your file you need to move it to your destination url
                  try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                  print("\(fileURL) has completed downloading")
                  completion(true, destinationUrl)
              } catch let error as NSError {
                  print(error.localizedDescription)
                  completion(false, nil)
              }
          }).resume()
      }
  }
  
  static func getMainFile(fileURL: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    let url = Bundle.main.url(forResource: fileURL as String, withExtension: nil)
    if (url != nil) {
      completion(true, url)
    }
    else {
      completion(false, nil)
    }
  }
  
  static func parseEncodedString(encodedData: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    if let decodedData = Data(base64Encoded: encodedData, options: .ignoreUnknownCharacters) {
        let image = UIImage(data: decodedData)
    }
  }
}
