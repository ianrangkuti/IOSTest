//
//  UnderlinedTextField.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class UnderlinedTextField: UITextField {
  private let defaultUnderlineColor = UIColor.gray
  private let bottomLine = UIView()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    borderStyle = .none
    bottomLine.translatesAutoresizingMaskIntoConstraints = false
    bottomLine.backgroundColor = defaultUnderlineColor
    self.addSubview(bottomLine)
    
    bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
    bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }

  func focused() {
    bottomLine.backgroundColor = .blue
  }

  func unFocused() {
    bottomLine.backgroundColor = defaultUnderlineColor
  }
  
  override func becomeFirstResponder() -> Bool {
    focused()
    return super.becomeFirstResponder()
  }
  
  override func resignFirstResponder() -> Bool {
    unFocused()
    return super.resignFirstResponder()
  }
}
