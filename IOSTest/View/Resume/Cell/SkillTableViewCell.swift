//
//  SkillTableViewCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

class SkillTableViewCell: UITableViewCell {
  
  @IBOutlet weak var skillLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(skillName: String) {
    skillLabel.text = "- \(skillName)"
  }
}
