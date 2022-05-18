//
//  ProjectDetailTableViewCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

class ProjectDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var projectNameLabel: UILabel!
  @IBOutlet weak var projectRoleLabel: UILabel!
  @IBOutlet weak var technologyUsedLabel: UILabel!
  @IBOutlet weak var projectSummaryLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(projectName: String, projectRole: String, teamSize: String, technologyUsed: String, projectSummary: String) {
    projectNameLabel.text = projectName
    projectRoleLabel.text = "Role: \(projectRole) with \(teamSize) People"
    technologyUsedLabel.text = "Technology used: \(technologyUsed)"
    projectSummaryLabel.text = "Poject Summary:\n\(projectSummary)"
  }
}
