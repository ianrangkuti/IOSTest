//
//  WorkSummaryTableViewCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

class WorkSummaryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(companyName: String, workDuration: String) {
    companyNameLabel.text = companyName
    durationLabel.text = "Working duration: \(workDuration)"
  }
}
