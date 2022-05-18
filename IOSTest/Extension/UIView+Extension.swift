//
//  UIView+Extension.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import UIKit

extension UIView {
  func fixInView(_ container: UIView!) {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.frame = container.frame
    container.addSubview(self)
    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
  }
  
  func exportAsPdfFromView(completion: @escaping (_ url: String?) -> Void) {
    let pdfPageFrame = self.bounds
    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
    UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
    guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
    self.layer.render(in: pdfContext)
    UIGraphicsEndPDFContext()
    let urlString = self.saveViewPdf(data: pdfData)
    if !urlString.isEmpty {
      completion(urlString)
    }
    return
  }
  
  // Save pdf file in document directory
  func saveViewPdf(data: NSMutableData) -> String {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let docDirectoryPath = paths[0]
    let pdfPath = docDirectoryPath.appendingPathComponent("resume.pdf")
    if data.write(to: pdfPath, atomically: true) {
      return pdfPath.path
    } else {
      return ""
    }
  }
}

