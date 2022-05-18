//
//  GlobalFunction.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import UIKit

class GlobalVariable {
  static let pageWidth: Double = 8.5 * 75 /// U.S. letter size 8.5 x 11
  static let pageHeight: Double = 11 * 75 /// Multiply the size by 72 points per inch
  /// Turn this `true` to see the location where the PDF file is being saved on simulator
  static let showSavedPDFLocation: Bool = true
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate

func resignFirstResponderGlobally() {
  func resignFirstResponder(forSubviewsOf view: UIView) -> Bool {
    for uiView in view.subviews {
      if uiView.isFirstResponder && (uiView is UITextView || uiView is UITextField) {
        uiView.resignFirstResponder()
        return true
      } else if resignFirstResponder(forSubviewsOf: uiView) {
        return true
      }
    }
    return false
  }

  if let globalView = appDelegate.window?.rootViewController?.view {
    _ = resignFirstResponder(forSubviewsOf: globalView)
  }
}

func dismissKeyboard() {
  UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
