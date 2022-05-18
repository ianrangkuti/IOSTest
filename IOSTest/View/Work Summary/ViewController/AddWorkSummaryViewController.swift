//
//  AddWorkSummaryViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class AddWorkSummaryViewController: UIViewController {
  
  @IBOutlet weak var companyTextField: UnderlinedTextField! {
    didSet {
      companyTextField.delegate = self
    }
  }
  @IBOutlet weak var workDurationTextField: UnderlinedTextField! {
    didSet {
      workDurationTextField.delegate = self
    }
  }
  @IBOutlet weak var saveButton: UIButton! {
    didSet {
      saveButton.layer.cornerRadius = 10
    }
  }
  
  private weak var callback: WorkSummaryProtocol?
  
  init(callback: WorkSummaryProtocol) {
    self.callback = callback
    super.init(nibName: "AddWorkSummaryView", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: UITextFieldDelegate
extension AddWorkSummaryViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.becomeFirstResponder()
    return true
  }
}

//MARK: Action
extension AddWorkSummaryViewController {
  @IBAction func saveButtonTapped(_ sender: Any) {
    self.save()
  }
}

//MARK: Action
private extension AddWorkSummaryViewController {
  func save() {
    let companyName = companyTextField.text ?? ""
    let workDuration = workDurationTextField.text ?? ""
    callback?.add(companyName: companyName, workDuration: workDuration)
    self.dismiss(animated: true)
  }
}
