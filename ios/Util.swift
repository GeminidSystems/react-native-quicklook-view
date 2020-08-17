//
//  Util.swift
//  ReactPOC
//
//  Created by Geoffrey Xue on 8/14/20.
//

import Foundation

public enum FileSource: Int {
  case Local
  case Downloadable
  case Base64
}

public enum FileType: String {
  case png
  case jpg
  case jpeg
  case pdf
  case mp4
  case ppsx
}

public class Util {
  static func getFile(fileID: NSString, src: NSString, fileType: NSString?, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    if (src.contains("file:///")) {
      retrieveFile(fileURL: src as String, id: fileID as String) { (_ success: Bool, fileLocation: URL?) in
        completion(success, fileLocation)
      }
    }
    else
    if (src.contains("http://") || src.contains("https://")) {
        downloadFile(fileURL: src as String, id: fileID as String) { (_ success: Bool, fileLocation: URL?) in
          completion(success, fileLocation)
        }
    }
    else {
      parseBase64(fileData: src as String, fileType: FileType.init(rawValue: fileType! as String)!, id: fileID as String)  { (_ success: Bool, fileLocation: URL?) in
        completion(success, fileLocation)
      }
    }
  }
  
  static func retrieveFile(fileURL: String, id: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {

    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // Destination URL is a combination of the id and the file type (.png, .pdf, etc.)
    let destinationUrl = documentsDirectoryURL.appendingPathComponent(id + "." + fileURL.components(separatedBy: ".").last!)
    
    // to check if file exists
    if FileManager.default.fileExists(atPath: destinationUrl.path) {
      debugPrint("The file already exists at path")
      completion(true, destinationUrl)
    }
    else {
      completion(false, nil)
    }
  }
  
  static func downloadFile(fileURL: String, id: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    print("downloading file")
    let itemUrl = URL(string: fileURL)
    
    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // Destination URL is a combination of the id and the file type (.png, .pdf, etc.)
    let destinationUrl = documentsDirectoryURL.appendingPathComponent(id + "." + fileURL.components(separatedBy: ".").last!)
    
    // If a file with the id already exists, delete and attempt to rerun function
    if FileManager.default.fileExists(atPath: destinationUrl.path) {
      print("File exists already, deleting")
      do {
        try FileManager.default.removeItem(atPath: destinationUrl.path)
        downloadFile(fileURL: fileURL, id: id) { (success: Bool, fileLocation: URL?) in
          completion(success, fileLocation)
        }
      }
      catch {
        print("File failed to delete")
        completion(false, nil)
      }
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
  
  static func parseBase64(fileData: String, fileType: FileType, id: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let destinationURL = documentsDirectoryURL.appendingPathComponent(id + "." + fileType.rawValue)
    
    // If a file with the id already exists, delete and attempt to rerun function
    if FileManager.default.fileExists(atPath: destinationURL.path) {
      do {
        try FileManager.default.removeItem(atPath: destinationURL.path)
         parseBase64(fileData: fileData, fileType: fileType, id: id) {(_ success: Bool,_ fileLocation: URL?) in
            completion(success, fileLocation)
          }
      }
      catch {
        print("File failed to delete")
        completion(false, nil)
      }
    }
    else {
      let convertedData = Data(base64Encoded: fileData)
      
      if (convertedData == nil) {
        print("No data found in file")
        completion(false, nil)
        return
      }
      
      do {
        try convertedData!.write(to: destinationURL)
        completion(true, destinationURL)
      }
      catch {
        print("Failed to write to file")
        completion(false, nil)
      }
    }

  }
}
