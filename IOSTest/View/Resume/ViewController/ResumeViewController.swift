//
//  ResumeViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import Foundation
import UIKit

enum ResumeCellView: Int {
  case profile = 0
  case skill = 1
  case workSummary = 2
  case educationDetails = 3
  case projectDetails = 4
}

class ResumeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var profileDetail: PersonalDetail = PersonalDetail()
  private var profileId: String = ""
  lazy var viewModel: ResumeViewModel = {
    ResumeViewModelImplementation()
  }()
  
  let sectionNumber: Int = 5
  
  static func instantiate(profileId id: String) -> ResumeViewController {
    let vc = UIStoryboard(name: "ResumeView", bundle: nil).instantiateViewController(withIdentifier: "ResumeViewController") as! ResumeViewController
    vc.profileId = id
    return vc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadData()
  }
}

// MARK: Action
extension ResumeViewController {
  @IBAction func backButtonTapped(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  @IBAction func editButtonTapped(_ sender: Any) {
    self.callAddResumePage()
  }
  
  @IBAction func shareButtonTapped(_ sender: Any) {
    self.shareUsingPDF()
  }
}

extension ResumeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionNumber
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let cellType = ResumeCellView(rawValue: section) ?? .profile
    switch cellType {
    case .profile:
      return 1
    case .skill:
      return profileDetail.skillList.count
    case .workSummary:
      return profileDetail.workSummary.count
    case .educationDetails:
      return profileDetail.educationDetails.count
    case .projectDetails:
      return profileDetail.projectDetails.count
    }
  }
}

extension ResumeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = indexPath.row
    let section = indexPath.section
    let cellType = ResumeCellView(rawValue: section) ?? .profile
    switch cellType {
    case .profile:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoTableViewCell") as? PersonalInfoTableViewCell else { return UITableViewCell() }
      cell.set(name: profileDetail.name, imagePath: profileDetail.picture, mobileNumber: profileDetail.mobileNumber, email: profileDetail.email, residenceAddress: profileDetail.residenceAddress, careerObjective: profileDetail.careerObjective, yearsOfExperience: profileDetail.yearsOfExperience)
      return cell
    case .skill:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkillTableViewCell") as? SkillTableViewCell,
            let skillName = profileDetail.skillList[safe: row] else { return UITableViewCell() }
      cell.set(skillName: skillName)
      return cell
    case .workSummary:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkSummaryTableViewCell") as? WorkSummaryTableViewCell,
            let workSummary = profileDetail.workSummary[safe: row] else { return UITableViewCell() }
      cell.set(companyName: workSummary.companyName, workDuration: workSummary.workDuration)
      return cell
    case .educationDetails:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "EducationTableViewCell") as? EducationTableViewCell,
            let educationDetail = profileDetail.educationDetails[safe: row]  else { return UITableViewCell() }
      cell.set(schoolName: educationDetail.schoolName, className: educationDetail.educationClassRaw, passingYear: educationDetail.passingYear, cgpa: educationDetail.cgpa)
      return cell
    case .projectDetails:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectDetailTableViewCell") as? ProjectDetailTableViewCell,
            let projectDetail = profileDetail.projectDetails[safe: row]  else { return UITableViewCell() }
      cell.set(projectName: projectDetail.projectName, projectRole: projectDetail.role, teamSize: projectDetail.teamSize, technologyUsed: projectDetail.technologyUsed, projectSummary: projectDetail.projectSummary)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let cellType = ResumeCellView(rawValue: section) ?? .profile
    switch cellType {
    case .profile:
      return 0
    default:
      return 30
    }
  }

  func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 55
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.001
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = ResumeHeaderTableViewCell.initWithNib()
    let cellType = ResumeCellView(rawValue: section) ?? .profile
    switch cellType {
    case .skill:
      view.set(title: "Skills")
    case .workSummary:
      view.set(title: "Work Summary")
    case .educationDetails:
      view.set(title: "Educations")
    case .projectDetails:
      view.set(title: "Project Details")
    case .profile:
      view.clearView()
    }
    return view
  }
}

//MARK: Other
private extension ResumeViewController {
  func setupUI() {
    let headerView = UIView()
    headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 0.001)
    tableView.tableHeaderView = headerView
    tableView.rowHeight = UITableView.automaticDimension // Note:Keep this else app crash in ios 10
    tableView.delegate = self
    tableView.dataSource = self
    tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 49, right: 0)
  }
  
  func callAddResumePage() {
    let vc = AddResumePageViewController.instantiate(profileId: profileId)
    let navController = UINavigationController(rootViewController: vc)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true, completion: nil)
  }
  
  func loadData() {
    profileDetail = viewModel.getPersonalDetailById(byId: profileId) ?? PersonalDetail()
    viewModel.setPersonalDetail(personalDetail: profileDetail)
    tableView.reloadData()
  }
  
  func shareUsingPDF() {
    self.tableView.exportAsPdfFromTable { url in
      if let urlString = url, let data = try? Data(contentsOf: URL(fileURLWithPath: urlString)) {
        let share = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        self.present(share, animated: true, completion: nil)
      }
    }
  }
}
