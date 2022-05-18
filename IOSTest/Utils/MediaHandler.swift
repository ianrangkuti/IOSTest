//
//  PhotoHandler.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation
import UIKit
import PermissionsKit

class MediaHandler: NSObject {
  
  static let shared = MediaHandler()
  fileprivate var currentVC: UIViewController!
  fileprivate var selectedPermissions: [Permission] = [.camera, .photoLibrary]
  
  //MARK: Internal Properties
  var imagePickedBlock: ((String) -> Void)?
  
  private func camera() {
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.sourceType = .camera
      currentVC.present(myPickerController, animated: true, completion: nil)
    }
  }
  
  private func photoLibrary() {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.sourceType = .photoLibrary
      currentVC.present(myPickerController, animated: true, completion: nil)
    }
  }
  
  func showActionSheet(vc: UIViewController) {
    currentVC = vc
    for permission in selectedPermissions {
      if permission.status != .authorized {
        showPermission()
        return
      }
    }
    
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
      self.camera()
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
      self.photoLibrary()
    }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    vc.present(actionSheet, animated: true, completion: nil)
  }
  
  func showPermission() {
    if selectedPermissions.isEmpty { return }
    let controller = PermissionsKit.dialog([.camera, .photoLibrary])

    // Set `DataSource` or `Delegate` if need.
    // By default using project texts and icons.
    controller.dataSource = self
    controller.delegate = self

    // If you want auto dismiss controler,
    // when all permissions has any determinated state
    // set dismiss mode `allPermissionsDeterminated`.
    // By default dismiss controller happen only when all permission allowed.
    controller.dismissCondition = .allPermissionsDeterminated

    // Always use this method for present
    controller.present(on: currentVC)
  }
}

extension MediaHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    currentVC.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.imageURL] as? URL {
      self.imagePickedBlock?(image.path)
    } else {
      print("Something went wrong")
    }
    currentVC.dismiss(animated: true, completion: nil)
  }
}

// MARK: - Permissions Data Source
extension MediaHandler: PermissionsDataSource {
  func configure(_ cell: PermissionTableViewCell, for permission: Permission) {

    // Here you can customise cell, like texts or colors.
    
    /*
    cell.permissionTitleLabel.text = "Title"
    cell.permissionDescriptionLabel.text = "Description"
    */
    
    // If you need change icon, choose one of this:
    
    /*
    cell.permissionIconView.setPermissionType(.bluetooth)
    cell.permissionIconView.setCustomImage(UIImage.init(named: "custom-name"))
    cell.permissionIconView.setCustomView(YourView())
    */
  }
  
  func deniedPermissionAlertTexts(for permission: Permission) -> DeniedPermissionAlertTexts? {
    // You can create custom texts
    
    /*
     let texts = DeniedPermissionAlertTexts()
     texts.titleText = "Permission denied"
     texts.descriptionText = "Please, go to Settings and allow permission."
     texts.actionText = "Settings"
     texts.cancelText = "Cancel"
     return texts
     */
    
    // or use default texts.
    
    return .default
    
    // For hide alert, simple return nil.
    // return nil
  }
}

// MARK: - Permissions Delegate
extension MediaHandler: PermissionsDelegate {
  func didHidePermissions(_ permissions: [Permission]) {
      print("Example App: did hide with permissions", permissions.map { $0.debugName })
  }
  
  func didAllowPermission(_ permission: Permission) {
      print("Example App: did allow", permission.debugName)
  }
  
  func didDeniedPermission(_ permission: Permission) {
      print("Example App: did denied", permission.debugName)
  }
}
