//
//  ResumeHeaderTableViewCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

class ResumeHeaderTableViewCell: UIView {
  static func initWithNib() -> ResumeHeaderTableViewCell {
    return Bundle.main.loadNibNamed("ResumeHeaderTableViewCell", owner: nil, options: nil)?.first as! ResumeHeaderTableViewCell
  }

  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func clearView() {
    self.backgroundColor = .white
  }
  
  func set(title: String) {
    titleLabel.text = title
  }
}
