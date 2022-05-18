//
//  WorkSummaryListViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

protocol WorkSummaryProtocol: AnyObject {
  func delete(workSummary: WorkSummary, uiView: UIView)
  func add(companyName: String, workDuration: String)
}

class WorkSummaryListViewController: UIViewController {
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var progressView: UIActivityIndicatorView!
  
  @IBOutlet weak var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 10
    }
  }
  private var viewModel: ResumeViewModel
  
  init(viewModel: ResumeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "WorkSummaryListView", bundle: nil)
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
extension WorkSummaryListViewController: WorkSummaryProtocol {
  func delete(workSummary: WorkSummary, uiView: UIView) {
    self.viewModel.removeWorkSummary(workSummary: workSummary)
    self.stackView.removeArrangedSubview(uiView)
    uiView.removeFromSuperview()
  }
  
  func add(companyName: String, workDuration: String) {
    let workSummary = self.viewModel.addWorkSummary(companyName: companyName, workDuration: workDuration)
    let workSummaryView = WorkSummaryView(workSummary: workSummary, callback: self)
    self.stackView.addArrangedSubview(workSummaryView)
    self.view.layoutIfNeeded()
    self.view.setNeedsLayout()
  }
}

// MARK: Action
extension WorkSummaryListViewController {
  @IBAction func nextButtonTapped(_ sender: Any) {
    self.goNextPage()
  }
  
  @IBAction func addWorkButtonTapped(_ sender: Any) {
    self.addWork()
  }
}

// MARK: Other
private extension WorkSummaryListViewController {
  func setupUI() {
    for workSummary in self.viewModel.personalDetail.workSummary {
      let workSummaryView = WorkSummaryView(workSummary: workSummary, callback: self)
      self.stackView.addArrangedSubview(workSummaryView)
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
  
  func addWork() {
    let vc = AddWorkSummaryViewController(callback: self)
    let navController = UINavigationController(rootViewController: vc)
    navController.modalPresentationStyle = .popover
    navController.setNavigationBarHidden(true, animated: false)
    self.present(navController, animated: true, completion: nil)
  }
}
