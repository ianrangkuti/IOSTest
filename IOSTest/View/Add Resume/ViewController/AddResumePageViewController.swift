//
//  AddResumePageViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import UIKit

class AddResumePageViewController: UIPageViewController {
  
  @IBOutlet weak var backBarButton: UIBarButtonItem!
  
  lazy var viewModel: ResumeViewModel = {
    ResumeViewModelImplementation()
  }()
  
  private var orderedViewControllers: [UIViewController] = []
  private var currentIndex: Int {
      guard let vc = viewControllers?.first else { return 0 }
      return orderedViewControllers.firstIndex(of: vc) ?? 0
  }
  private var personalDetail: PersonalDetail?
  private var profileId: String = ""
  
  static func instantiate(profileId id: String) -> AddResumePageViewController {
    let pager = UIStoryboard(name: "AddResume", bundle: nil).instantiateViewController(withIdentifier: "AddResumePageViewController") as! AddResumePageViewController
    pager.profileId = id
    return pager
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewController()
  }
}

// MARK: Action
extension AddResumePageViewController {
  @IBAction func backButtonTapped(_ sender: Any) {
    self.viewModel.goBack()
  }
}

// MARK: Others
private extension AddResumePageViewController {
  func setupViewController() {
    observe()
    orderedViewControllers.append(PersonalInfoViewController(viewModel: viewModel))
    orderedViewControllers.append(SkillListViewController(viewModel: viewModel))
    orderedViewControllers.append(WorkSummaryListViewController(viewModel: viewModel))
    orderedViewControllers.append(EducationListViewController(viewModel: viewModel))
    orderedViewControllers.append(ProjectListViewController(viewModel: viewModel))
    guard let firstVC = orderedViewControllers[safe: 0] else { return }
    setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
  }
  
  func observe() {
    self.personalDetail = viewModel.getPersonalDetailById(byId: self.profileId) ?? PersonalDetail()
    self.viewModel.setPersonalDetail(personalDetail: self.personalDetail)
    self.viewModel.pagePosition.bind { [unowned self] pageNumber in
      if pageNumber < 0 {
        self.dismiss(animated: true)
        return
      }
      if pageNumber < self.orderedViewControllers.count {
        if pageNumber > self.currentIndex {
          self.setViewControllers([self.orderedViewControllers[pageNumber]], direction: .forward, animated: true)
        } else if pageNumber < self.currentIndex {
          self.setViewControllers([self.orderedViewControllers[pageNumber]], direction: .reverse, animated: true)
        }
      }
    }
    
    self.viewModel.submitResponse.bind { [unowned self] status in
      switch status {
      case .success:
        self.showAlert(title: "Success", message: "Your resume are created") {
          self.dismiss(animated: true)
        }
      case .failure:
        self.showAlert(title: "Error", message: "Have issue when saving your resume, please check your data again") { }
      default:
        break
      }
    }
  }
  
  func showAlert(title: String, message: String, completion: @escaping (() -> Void)) {
    let alert = UIAlertController(title: title, message: title, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
      completion()
      alert.dismiss(animated: false)
    }))
    self.present(alert, animated: false)
  }
}
