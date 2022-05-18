//
//  PersonalInfoViewController.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import Foundation
import UIKit

class PersonalInfoViewController: UIViewController {
  
  @IBOutlet weak var userPictureImageView: UIImageView! {
    didSet {
      userPictureImageView.layer.cornerRadius = userPictureImageView.frame.size.width / 2
      userPictureImageView.clipsToBounds = true
      userPictureImageView.layer.borderWidth = 2.0
      userPictureImageView.layer.borderColor = UIColor.white.cgColor
      userPictureImageView.isUserInteractionEnabled = true
      userPictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
    }
  }
  @IBOutlet weak var userNameTextField: UnderlinedTextField! {
    didSet {
      userNameTextField.delegate = self
    }
  }
  @IBOutlet weak var emailTextField: UnderlinedTextField! {
    didSet {
      emailTextField.delegate = self
    }
  }
  @IBOutlet weak var phoneNumberTextField: UnderlinedTextField! {
    didSet {
      phoneNumberTextField.delegate = self
    }
  }
  @IBOutlet weak var addressTextField: UnderlinedTextField! {
    didSet {
      addressTextField.delegate = self
    }
  }
  @IBOutlet weak var yearOfExperienceTextField: UnderlinedTextField! {
    didSet {
      yearOfExperienceTextField.delegate = self
    }
  }
  @IBOutlet weak var careerObjectiveTextView: UITextView! {
    didSet {
      careerObjectiveTextView.text = "Career Objective"
      careerObjectiveTextView.textColor = .lightGray
      careerObjectiveTextView.layer.cornerRadius = 10
      careerObjectiveTextView.layer.borderWidth = 1
      careerObjectiveTextView.layer.borderColor = UIColor.gray.cgColor
      careerObjectiveTextView.delegate = self
    }
  }
  @IBOutlet weak var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 10
    }
  }
  @IBOutlet weak var progressView: UIActivityIndicatorView!
  
  private var viewModel: ResumeViewModel
  private var imageUrlPath: String = ""
  
  init(viewModel: ResumeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: "PersonalInfoView", bundle: nil)
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
extension PersonalInfoViewController {
  @IBAction func nextButtonTapped(_ sender: Any) {
    goNext()
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    guard let _ = tapGestureRecognizer.view as? UIImageView else { return }
    MediaHandler.shared.showActionSheet(vc: self)
    MediaHandler.shared.imagePickedBlock = { [weak self] (imagePath) in
      self?.imageUrlPath = imagePath
      self?.userPictureImageView.image = UIImage().setImageFromLocalPath(path: imagePath)
    }
  }
}

// MARK: UITextFieldDelegate
extension PersonalInfoViewController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.becomeFirstResponder()
    return true
  }
}

// MARK: UITextFieldDelegate
extension PersonalInfoViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = nil
      textView.textColor = .black
      textView.layer.borderColor = UIColor.blue.cgColor
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Career Objective"
      textView.textColor = .lightGray
      textView.layer.borderColor = UIColor.gray.cgColor
    }
  }
}

// MARK: Others
private extension PersonalInfoViewController {
  
  func setUpData() {
    let personalDetail = self.viewModel.personalDetail
    self.userNameTextField.text = personalDetail.name
    self.userPictureImageView.image = UIImage().setImageFromLocalPath(path: personalDetail.picture)
    self.phoneNumberTextField.text = personalDetail.mobileNumber
    self.emailTextField.text = personalDetail.email
    self.addressTextField.text = personalDetail.residenceAddress
    self.yearOfExperienceTextField.text = personalDetail.yearsOfExperience
    if !personalDetail.careerObjective.isEmpty {
      self.careerObjectiveTextView.text = personalDetail.careerObjective
      self.careerObjectiveTextView.textColor = .black
    }
  }
  
  func observe() {
    self.viewModel.isSubmitOnProgress.bind { [unowned self] status in
      progressView.isHidden = !status
    }
  }
  
  func goNext() {
    if let username = self.userNameTextField.text, !username.isEmpty {
      let imagePath = self.imageUrlPath
      let mobileNumber = self.phoneNumberTextField.text ?? ""
      let email = self.emailTextField.text ?? ""
      let address = self.addressTextField.text ?? ""
      let yearOfExperience = self.yearOfExperienceTextField.text ?? ""
      var careerObjective = ""
      if self.careerObjectiveTextView.textColor == .black {
        careerObjective = self.careerObjectiveTextView.text ?? ""
      }
      viewModel.addPersonalInfo(name: username, imagePath: imagePath, mobileNumber: mobileNumber, email: email, residenceAddress: address, careerObjective: careerObjective, yearsOfExperience: yearOfExperience)
      viewModel.goNextPage()
    } else {
      let alert = UIAlertController(title: "Error", message: "Please insert atleast your name", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
        alert.dismiss(animated: false)
      }))
      self.present(alert, animated: false)
    }
  }
}
