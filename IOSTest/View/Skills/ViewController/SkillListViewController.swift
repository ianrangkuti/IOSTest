//
//  SkillListViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

protocol SkillProtocol: AnyObject {
  func deleteItem(skillName: String, uiView: UIView)
}

class SkillListViewController: UIViewController {
  
  @IBOutlet weak var skillTextField: UnderlinedTextField!
  @IBOutlet weak var skillStackView: UIStackView!
  @IBOutlet weak var progressView: UIActivityIndicatorView!
  @IBOutlet weak var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 10
    }
  }
  
  private var viewModel: ResumeViewModel
  
  init(viewModel: ResumeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "SkillListView", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    observe()
    setUpData()
  }
}

// MARK: Action
extension SkillListViewController {
  @IBAction func nextButtonTapped(_ sender: Any) {
    self.goNextPage()
  }
  
  @IBAction func addSkillButtonTapped(_ sender: Any) {
    self.createSkill()
  }
}

// MARK: SkillProtocol
extension SkillListViewController: SkillProtocol {
  func deleteItem(skillName: String, uiView: UIView) {
    self.viewModel.removeSkill(skillName: skillName)
    self.clearStackView(uiView: uiView)
  }
}

// MARK: Other
private extension SkillListViewController {
  func observe() {
    self.viewModel.isSubmitOnProgress.bind { [unowned self] status in
      progressView.isHidden = !status
    }
  }
  
  func goNextPage() {
    self.viewModel.goNextPage()
  }
  
  func createSkill() {
    guard let skillName = self.skillTextField.text, !skillName.isEmpty else { return }
    self.skillTextField.text = ""
    self.viewModel.addSkill(skillName: skillName)
    let skillView = SkillView(skillName: skillName, callback: self)
    self.skillStackView.addArrangedSubview(skillView)
    self.view.layoutIfNeeded()
    self.view.setNeedsLayout()
  }
  
  func setUpData() {
    let skills = self.viewModel.personalDetail.skillList
    for skillName in skills {
      let skillView = SkillView(skillName: skillName, callback: self)
      self.skillStackView.addArrangedSubview(skillView)
    }
  }
  
  func clearStackView(uiView: UIView) {
    self.skillStackView.removeArrangedSubview(uiView)
    uiView.removeFromSuperview()
  }
}
