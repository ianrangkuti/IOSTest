//
//  MainViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 27/04/22.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
  
  @IBOutlet weak var addActionBar: UIBarButtonItem! {
    didSet {
      
    }
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  lazy var viewModel: ResumeViewModel = {
    ResumeViewModelImplementation()
  }()
  
  var listPersonalData: [PersonalDetail] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Realm DB Location: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadData()
  }
}

// MARK: Action
extension MainViewController {
  @IBAction func addButtonTapped(_ sender: Any) {
    callAddResumePage()
  }
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listPersonalData.count
  }
}

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let personalDetail = listPersonalData[safe: indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTableViewCell") as? UserDataTableViewCell else { return UITableViewCell() }
    cell.set(name: personalDetail?.name ?? "", createdAt: personalDetail?.createdTs ?? 0)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = indexPath.row
    guard let personalDetail = listPersonalData[safe: row] else {return}
    self.showResumeDetailPage(id: personalDetail.id)
  }
}


// MARK: Other Function
private extension MainViewController {
  func setupUI() {
    tableView.rowHeight = UITableView.automaticDimension // Note:Keep this else app crash in ios 10
    tableView.delegate = self
    tableView.dataSource = self
    tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 49, right: 0)
    loadData()
  }
  
  func loadData() {
    listPersonalData = viewModel.getListPersonalDetail()
    tableView.reloadData()
  }
  
  func callAddResumePage() {
    let vc = AddResumePageViewController.instantiate(profileId: "")
    let navController = UINavigationController(rootViewController: vc)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true, completion: nil)
  }
  
  func showResumeDetailPage(id: String) {
    let vc = ResumeViewController.instantiate(profileId: id)
    let navController = UINavigationController(rootViewController: vc)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true, completion: nil)
  }
}
