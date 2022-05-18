//
//  EducationListViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

protocol EducationProtocol: AnyObject {
  func delete(education: EducationDetail, uiView: UIView)
  func add(schoolName: String, educationClass: String, passingYear: String, cgpa: String)
}

class EducationListViewController: UIViewController {
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 10
    }
  }
  @IBOutlet weak var progressView: UIActivityIndicatorView!
  
  private var viewModel: ResumeViewModel
  
  init(viewModel: ResumeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "EducationListView", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    observe()
    setupUI()
  }
}

// MARK: WorkSummaryProtocol
extension EducationListViewController: EducationProtocol {
  func delete(education: EducationDetail, uiView: UIView) {
    self.viewModel.removeEducation(education: education)
    self.stackView.removeArrangedSubview(uiView)
    uiView.removeFromSuperview()
  }
  
  func add(schoolName: String, educationClass: String, passingYear: String, cgpa: String) {
    let education = self.viewModel.addEducation(schoolName: schoolName, educationClass: educationClass, passingYear: passingYear, cgpa: cgpa)
    let educationView = EducationView(educationDetail: education, callback: self)
    self.stackView.addArrangedSubview(educationView)
    self.view.layoutIfNeeded()
    self.view.setNeedsLayout()
  }
}

extension EducationListViewController {
  @IBAction func nextButtonTapped(_ sender: Any) {
    self.goNextPage()
  }
  
  @IBAction func addEducationButtonTapped(_ sender: Any) {
    self.addEducation()
  }
}

// MARK: Other
private extension EducationListViewController {
  func setupUI() {
    for education in self.viewModel.personalDetail.educationDetails {
      let educationView = EducationView(educationDetail: education, callback: self)
      self.stackView.addArrangedSubview(educationView)
    }
    self.view.layoutIfNeeded()
    self.view.setNeedsLayout()
  }
  
  func observe() {
    self.viewModel.isSubmitOnProgress.bind { [unowned self] status in
      self.progressView.isHidden = !status
    }
  }
  
  func goNextPage() {
    self.viewModel.goNextPage()
  }
  
  func addEducation() {
    let vc = AddEducationViewController(callback: self)
    let navController = UINavigationController(rootViewController: vc)
    navController.modalPresentationStyle = .popover
    navController.setNavigationBarHidden(true, animated: false)
    self.present(navController, animated: true, completion: nil)
  }
}

