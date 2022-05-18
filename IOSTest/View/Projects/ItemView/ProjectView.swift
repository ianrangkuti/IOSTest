//
//  ProjectView.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class ProjectView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLable: UILabel!
  @IBOutlet weak var smallLabel: UILabel!
  @IBOutlet weak var clearButton: UIButton! {
    didSet {
      clearButton.titleLabel?.text = " "
    }
  }
  
  let kCONTENT_XIB_NAME = "ProjectView"
  
  private var projectDetail: ProjectDetail?
  private weak var callback: ProjectProtocol?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  convenience init(projectDetail: ProjectDetail, callback: ProjectProtocol) {
    self.init(frame: .zero)
    self.callback = callback
    self.projectDetail = projectDetail
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
extension ProjectView {
  @IBAction func deleteButtonTapped(_ sender: Any) {
    guard let _projectDetail = projectDetail else { return }
    self.callback?.delete(project: _projectDetail, uiView: self)
  }
}

//MARK: Other
private extension ProjectView {
  func displayLayout() {
    titleLabel.text = "Project Name:  \(projectDetail?.projectName ?? "")"
    subTitleLable.text = "Team Size: \(projectDetail?.teamSize ?? "")"
    smallLabel.text = "Role as \(projectDetail?.role ?? "")"
  }
}


