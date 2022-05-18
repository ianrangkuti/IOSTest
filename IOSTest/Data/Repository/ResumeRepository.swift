//
//  ResumeRepository.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import Foundation
import RealmSwift

enum SaveStatus {
  case success
  case failure
  case nothing
}

protocol ResumeRepository {
  func findResume(byId id: String) -> PersonalDetail?
  func listAllResume() -> [PersonalDetail]
  func save(data: PersonalDetail, completion: @escaping (SaveStatus) -> Void)
}

final class ResumeRepositoryImplementation: ResumeRepository {
  
  fileprivate var realm: Realm? {
    do {
      return try Realm()
    } catch {
      print("Error Realm init : \(error.localizedDescription)")
      return nil
    }
  }
  
  func findResume(byId id: String) -> PersonalDetail? {
    guard let _realm = realm else { return nil }
    let personalDetails: Results<PersonalDetail> = _realm.objects(PersonalDetail.self).filter("id = '\(id)'")
    return personalDetails.first
  }

  func listAllResume() -> [PersonalDetail] {
    guard let _realm = realm else { return [] }
    let personalDetails = _realm.objects(PersonalDetail.self).sorted { (left, right) -> Bool in
      return left.createdTs > right.createdTs
    }
    return personalDetails
  }
  
  func save(data: PersonalDetail, completion: @escaping (SaveStatus) -> Void) {
    guard let _realm = realm else {
      completion(.failure)
      return
    }
    do {
      try _realm.write {
        data.isSaved = true
        _realm.add(data, update: .modified)
        completion(.success)
      }
    } catch {
      completion(.failure)
    }
  }
}
