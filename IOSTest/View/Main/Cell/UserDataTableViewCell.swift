//
//  UserDataCell.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var createAtLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func set(name: String, createdAt: Int64) {
    let date = Date(timeIntervalSince1970: TimeInterval(createdAt) / 1000)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, h:mm a"
    createAtLabel.text = "Created At \(dateFormatter.string(from: date))"
    nameLabel.text = "Name: \(name)"
  }
}
