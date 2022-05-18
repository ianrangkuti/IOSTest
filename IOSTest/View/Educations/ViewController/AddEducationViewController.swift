//
//  AddEducationViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit

class AddEducationViewController: UIViewController {
  
  @IBOutlet weak var schoolNameTextField: UnderlinedTextField! {
    didSet {
      schoolNameTextField.delegate = self
    }
  }
  
  @IBOutlet weak var classTextField: UnderlinedTextField! {
    didSet {
      classTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(classTapped(tapGestureRecognizer:))))
    }
  }
  @IBOutlet weak var passingYearTextField: UnderlinedTextField! {
    didSet {
      passingYearTextField.delegate = self
    }
  }
  @IBOutlet weak var cgpaTextField: UnderlinedTextField! {
    didSet {
      cgpaTextField.delegate = self
    }
  }
  @IBOutlet weak var saveButton: UIButton! {
    didSet {
      saveButton.layer.cornerRadius = 10
    }
  }
  
  private weak var callback: EducationProtocol?
  
  init(callback: EducationProtocol) {
    self.callback = callback
    super.init(nibName: "AddEducationView", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: UITextFieldDelegate
extension AddEducationViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case classTextField:
      break
    default:
      textField.becomeFirstResponder()
    }
    return true
  }
}

//MARK: Action
extension AddEducationViewController {
  @IBAction func saveButtonTapped(_ sender: Any) {
    save()
  }
  
  @objc func classTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    guard let _ = tapGestureRecognizer.view as? UnderlinedTextField else { return }
    showClassOption()
  }
}

//MARK: Action
private extension AddEducationViewController {
  func save() {
    let schoolName = schoolNameTextField.text ?? ""
    let className = classTextField.text ?? ""
    let passingYear = passingYearTextField.text ?? ""
    let cgpa = cgpaTextField.text ?? ""
    callback?.add(schoolName: schoolName, educationClass: className, passingYear: passingYear, cgpa: cgpa)
    self.dismiss(animated: true)
  }
  
  func showClassOption() {
    let actionSheet = UIAlertController(title: "Class Option", message: "Please Select an Option", preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: EducationClass.X.rawValue, style: .default , handler:{ (UIAlertAction) in
      self.classTextField.text = EducationClass.X.rawValue
    }))
    actionSheet.addAction(UIAlertAction(title: EducationClass.XII.rawValue, style: .default , handler:{ (UIAlertAction) in
      self.classTextField.text = EducationClass.XII.rawValue
    }))
    actionSheet.addAction(UIAlertAction(title: EducationClass.Graduation.rawValue, style: .default , handler:{ (UIAlertAction) in
      self.classTextField.text = EducationClass.Graduation.rawValue
    }))
    
    self.present(actionSheet, animated: true, completion: nil)
  }
}
