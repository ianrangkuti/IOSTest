//
//  UITableView+Extension.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 02/05/22.
//

import UIKit

extension UITableView {
    
  // Export pdf from UITableView and save pdf in drectory and return pdf file path
  func exportAsPdfFromTable(completion: @escaping (_ url: String?) -> Void) {
    let originalBounds = self.bounds
    self.bounds = CGRect(x:originalBounds.origin.x, y: originalBounds.origin.y, width: self.contentSize.width, height: self.contentSize.height)
    let pdfPageFrame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.contentSize.height)

    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
    UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
    guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
    self.layer.render(in: pdfContext)
    UIGraphicsEndPDFContext()
    self.bounds = originalBounds
    // Save pdf data
    let urlString = self.saveTablePdf(data: pdfData)
    if !urlString.isEmpty {
      completion(urlString)
    } else {
      return
    }
  }
    
  // Save pdf file in document directory
  func saveTablePdf(data: NSMutableData) -> String {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let docDirectoryPath = paths[0]
    let pdfPath = docDirectoryPath.appendingPathComponent("Resume.pdf")
    if data.write(to: pdfPath, atomically: true) {
      return pdfPath.path
    } else {
      return ""
    }
  }
}
