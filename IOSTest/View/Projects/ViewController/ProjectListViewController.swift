//
//  ProjectListViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

protocol ProjectProtocol: AnyObject {
  func delete(project: ProjectDetail, uiView: UIView)
  func add(projectName: String, teamSize: String, projectSummary: String, technologyUsed: String, role: String)
}

class ProjectListViewController: UIViewController {
  
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var progressView: UIActivityIndicatorView!
  @IBOutlet weak var doneButton: UIButton! {
    didSet {
      doneButton.layer.cornerRadius = 10
    }
  }
  
  private var viewModel: ResumeViewModel
  
  init(viewModel: ResumeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "ProjectListView", bundle: nil)
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
extension ProjectListViewController: ProjectProtocol {
  func delete(project: ProjectDetail, uiView: UIView) {
    self.viewModel.removeProject(project: project)
    self.stackView.removeArrangedSubview(uiView)
    uiView.removeFromSuperview()
  }
  
  func add(projectName: String, teamSize: String, projectSummary: String, technologyUsed: String, role: String) {
    let projectDetail = self.viewModel.addProject(projectName: projectName, teamSize: teamSize, projectSummary: projectSummary, technologyUsed: technologyUsed, role: role)
    let projectView = ProjectView(projectDetail: projectDetail, callback: self)
    self.stackView.addArrangedSubview(projectView)
    self.view.layoutIfNeeded()
    self.view.setNeedsLayout()
  }
}

extension ProjectListViewController {
  @IBAction func nextButtonTapped(_ sender: Any) {
    self.goNextPage()
  }
  
  @IBAction func addButtonTapped(_ sender: Any) {
    self.addProject()
  }
}

// MARK: Other
private extension ProjectListViewController {
  func setupUI() {
    for projectDetail in self.viewModel.personalDetail.projectDetails {
      let projectView = ProjectView(projectDetail: projectDetail, callback: self)
      self.stackView.addArrangedSubview(projectView)
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
    self.viewModel.submitData()
  }
  
  func addProject() {
    let vc = AddProjectViewController(callback: self)
    let navController = UINavigationController(rootViewController: vc)
    navController.modalPresentationStyle = .popover
    navController.setNavigationBarHidden(true, animated: false)
    self.present(navController, animated: true, completion: nil)
  }
}

