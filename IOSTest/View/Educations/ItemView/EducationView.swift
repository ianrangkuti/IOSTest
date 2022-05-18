//
//  EducationView.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class EducationView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLable: UILabel!
  @IBOutlet weak var smallLabel: UILabel!
  @IBOutlet weak var moreSmallLabel: UILabel!
  
  @IBOutlet weak var clearButton: UIButton! {
    didSet {
      clearButton.titleLabel?.text = " "
    }
  }
  
  let kCONTENT_XIB_NAME = "EducationView"
  
  private var educationDetail: EducationDetail?
  private weak var callback: EducationProtocol?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  convenience init(educationDetail: EducationDetail, callback: EducationProtocol) {
    self.init(frame: .zero)
    self.callback = callback
    self.educationDetail = educationDetail
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
extension EducationView {
  @IBAction func deleteButtonTapped(_ sender: Any) {
    guard let _educationDetail = educationDetail else {return}
    self.callback?.delete(education: _educationDetail, uiView: self)
  }
}

//MARK: Other
private extension EducationView {
  func displayLayout() {
    titleLabel.text = educationDetail?.schoolName
    subTitleLable.text = "Class \(educationDetail?.educationClass.rawValue ?? "")"
    smallLabel.text = "Passing Year at \(educationDetail?.passingYear ?? "")"
    moreSmallLabel.text = "CGPA: \(educationDetail?.cgpa ?? "")"
  }
}

