//
//  EducationDetail.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import RealmSwift

enum EducationClass: String {
  case X
  case XII
  case Graduation
}

class EducationDetail: Object {
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var schoolName: String = ""
  @objc dynamic var educationClassRaw: String = ""
  @objc dynamic var passingYear: String = ""
  @objc dynamic var cgpa: String = ""
  @objc dynamic var createdTs: Int64 = Int64(Date().timeIntervalSince1970 * 1000)
  var educationClass: EducationClass {
    get {
        guard let educationClassEnum = EducationClass(rawValue: educationClassRaw) else { return .X }
        return educationClassEnum
    }
    set { educationClassRaw = newValue.rawValue }
  }
}
