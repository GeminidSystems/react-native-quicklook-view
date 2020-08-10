//
//  Util.swift
//  ReactPOC
//
//  Created by Geoffrey Xue on 7/27/20.
//

import Foundation

public enum FileSource: Int {
    case Local
    case Downloadable
    case Main
    case Base64
}

public class Util {
  static func getFile(fileSource: FileSource, urlString: NSString?, fileData: NSString?, fileType: NSString?, fileID: NSString?, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {

    switch (fileSource) {
    case .Local:
      retrieveFile(fileURL: urlString! as String, id: fileID! as String) { (_ success: Bool,_ fileLocation: URL?) in
        completion(success, fileLocation)
      }
    case .Downloadable:
      downloadFile(fileURL: urlString! as String, id: fileID! as String) { (_ success: Bool,_ fileLocation: URL?) in
        print("Finished downloading file")
        print(fileLocation)
        completion(success, fileLocation)
      }
    case .Main:
      getMainFile(fileURL: urlString! as String) { (_ success: Bool,_ fileLocation: URL?) in
        completion(success, fileLocation)
      }
    case .Base64:
      parseBase64(fileData: fileData! as String, fileType: fileType! as String, id: fileID! as String) {(_ success: Bool,_ fileLocation: URL?) in
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

  static func getMainFile(fileURL: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    let url = Bundle.main.url(forResource: fileURL as String, withExtension: nil)
    if (url != nil) {
      completion(true, url)
    }
    else {
      completion(false, nil)
    }
  }

  static func parseBase64(fileData: String, fileType: String, id: String, completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void) {
    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let destinationURL = documentsDirectoryURL.appendingPathComponent(id + "." + fileType)

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
