//
//  UIImage+Extension.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

extension UIImage {
  
  func setImageFromLocalPath(path: String, placeHolderName: String = "profile_image") -> UIImage? {
    let fileURL = URL(fileURLWithPath: path)
    do {
      let imageData = try Data(contentsOf: fileURL)
      return UIImage(data: imageData)
    } catch {
      print("Error loading image : \(error)")
    }
    return UIImage(named: placeHolderName)
  }
}
