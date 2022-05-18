//
//  WorkSummaryView.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import UIKit

class WorkSummaryView: UIView {
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLable: UILabel!
  @IBOutlet weak var clearButton: UIButton! {
    didSet {
      clearButton.titleLabel?.text = " "
    }
  }
  
  let kCONTENT_XIB_NAME = "WorkSummaryView"
  
  private var workSummary: WorkSummary?
  private weak var callback: WorkSummaryProtocol?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  convenience init(workSummary: WorkSummary, callback: WorkSummaryProtocol) {
    self.init(frame: .zero)
    self.callback = callback
    self.workSummary = workSummary
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
extension WorkSummaryView {
  @IBAction func deleteButtonTapped(_ sender: Any) {
    guard let _workSummary = workSummary else {return}
    self.callback?.delete(workSummary: _workSummary, uiView: self)
  }
}

//MARK: Other
private extension WorkSummaryView {
  func displayLayout() {
    titleLabel.text = "CompanyName: \(workSummary?.companyName ?? "")"
    subTitleLable.text = "Duration: \(workSummary?.workDuration ?? "")"
  }
}
