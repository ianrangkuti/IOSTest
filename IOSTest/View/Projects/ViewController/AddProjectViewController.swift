//
//  AddProjectViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class AddProjectViewController: UIViewController {
  
  @IBOutlet weak var projectNameTextField: UnderlinedTextField! {
    didSet {
      projectNameTextField.delegate = self
    }
  }
  @IBOutlet weak var teamSizeTextField: UnderlinedTextField! {
    didSet {
      teamSizeTextField.delegate = self
    }
  }
  @IBOutlet weak var techNologyUsedTextField: UnderlinedTextField! {
    didSet {
      techNologyUsedTextField.delegate = self
    }
  }
  @IBOutlet weak var positionRoleTextField: UnderlinedTextField! {
    didSet {
      positionRoleTextField.delegate = self
    }
  }
  @IBOutlet weak var projectSummaryTextView: UITextView! {
    didSet {
      projectSummaryTextView.text = "Write your project summary in detail"
      projectSummaryTextView.textColor = .lightGray
      projectSummaryTextView.layer.cornerRadius = 10
      projectSummaryTextView.layer.borderWidth = 1
      projectSummaryTextView.layer.borderColor = UIColor.gray.cgColor
      projectSummaryTextView.delegate = self
    }
  }
  
  @IBOutlet weak var saveButton: UIButton! {
    didSet {
      saveButton.layer.cornerRadius = 10
    }
  }
  
  private weak var callback: ProjectProtocol?
  
  init(callback: ProjectProtocol) {
    self.callback = callback
    super.init(nibName: "AddProjectView", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: UITextFieldDelegate
extension AddProjectViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = .black
      textView.layer.borderColor = UIColor.blue.cgColor
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Write your project summary in detail"
      textView.textColor = .lightGray
      textView.layer.borderColor = UIColor.gray.cgColor
    }
  }
}

//MARK: UITextFieldDelegate
extension AddProjectViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.becomeFirstResponder()
    return true
  }
}

//MARK: Action
extension AddProjectViewController {
  @IBAction func saveButtonTapped(_ sender: Any) {
    save()
  }
}

//MARK: Action
private extension AddProjectViewController {
  func save() {
    let projectName = projectNameTextField.text ?? ""
    let teamSize = teamSizeTextField.text ?? ""
    let techNologyUsed = techNologyUsedTextField.text ?? ""
    let positionRole = positionRoleTextField.text ?? ""
    let projectSummary = projectSummaryTextView.text ?? ""
    callback?.add(projectName: projectName, teamSize: teamSize, projectSummary: projectSummary, technologyUsed: techNologyUsed, role: positionRole)
    self.dismiss(animated: true)
  }
}

