//
//  SkillView.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class SkillView: UIView {
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var skillLabel: UILabel!
  @IBOutlet weak var removeButton: UIButton! {
    didSet {
      removeButton.titleLabel?.text = ""
    }
  }
  
  let kCONTENT_XIB_NAME = "SkillView"
  
  private var skillName: String = ""
  private weak var callback: SkillProtocol?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  convenience init(skillName: String, callback: SkillProtocol) {
    self.init(frame: .zero)
    self.callback = callback
    self.skillName = skillName
    self.displayLayout()
  }
  
  override open var intrinsicContentSize: CGSize {
    return CGSize(width: 1.0, height: 30)
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
    contentView.fixInView(self)
  }
}

//MARK: Action
extension SkillView {
  @IBAction func deleteButtonTapped(_ sender: Any) {
    self.callback?.deleteItem(skillName: skillName, uiView: self)
  }
}

//MARK: Other
private extension SkillView {
  func displayLayout() {
    self.skillLabel.text = self.skillName
  }
}
