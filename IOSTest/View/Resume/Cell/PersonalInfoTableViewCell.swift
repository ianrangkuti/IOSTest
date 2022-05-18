//
//  PersonalInfoTableViewCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

class PersonalInfoTableViewCell: UITableViewCell {
  
  @IBOutlet weak var profilePictureImageView: UIImageView! {
    didSet {
      profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width / 2
      profilePictureImageView.clipsToBounds = true
      profilePictureImageView.layer.borderWidth = 2.0
      profilePictureImageView.layer.borderColor = UIColor.white.cgColor
    }
  }
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var mobileNumberLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var addresslabel: UILabel!
  @IBOutlet weak var workExperienceLabel: UILabel!
  @IBOutlet weak var careerObjectiveLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(name: String, imagePath: String, mobileNumber: String, email: String, residenceAddress: String, careerObjective: String, yearsOfExperience: String) {
    self.nameLabel.text = name
    self.profilePictureImageView.image = UIImage().setImageFromLocalPath(path: imagePath)
    self.mobileNumberLabel.text = "Mobile No. \(mobileNumber)"
    self.emailLabel.text = email
    self.addresslabel.text = "Address: \(residenceAddress)"
    self.workExperienceLabel.text = "\(yearsOfExperience) Years of experience"
    self.careerObjectiveLabel.text = "Career Objective: \n\(careerObjective)"
  }
}
