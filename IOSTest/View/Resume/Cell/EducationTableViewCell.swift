//
//  EducationTableViewCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

class EducationTableViewCell: UITableViewCell {
  @IBOutlet weak var schoolNameLabel: UILabel!
  @IBOutlet weak var classNameLabel: UILabel!
  @IBOutlet weak var passingYearLabel: UILabel!
  @IBOutlet weak var cgpaLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(schoolName: String, className: String, passingYear: String, cgpa: String) {
    schoolNameLabel.text = schoolName
    classNameLabel.text = "Class \(className)"
    passingYearLabel.text = "Passing Year: \(passingYear)"
    cgpaLabel.text = "CGPA: \(cgpa)"
  }
}
