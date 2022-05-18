//
//  PersonalDetail.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import RealmSwift

class PersonalDetail: Object {
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var name: String = ""
  @objc dynamic var picture: String = ""
  @objc dynamic var mobileNumber: String = ""
  @objc dynamic var email: String = ""
  @objc dynamic var residenceAddress: String = ""
  @objc dynamic var careerObjective: String = ""
  @objc dynamic var yearsOfExperience: String = ""
  @objc dynamic var createdTs: Int64 = Int64(Date().timeIntervalSince1970 * 1000)
  @objc dynamic var isSaved: Bool = false
  var workSummary: List<WorkSummary> = List<WorkSummary>()
  var skillList: List<String> = List<String>()
  var educationDetails: List<EducationDetail> = List<EducationDetail>()
  var projectDetails: List<ProjectDetail> = List<ProjectDetail>()
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
  func clone(personalDetail: PersonalDetail) {
    self.id = personalDetail.id
    self.name = personalDetail.name
    self.picture = personalDetail.picture
    self.mobileNumber = personalDetail.mobileNumber
    self.email = personalDetail.email
    self.residenceAddress = personalDetail.residenceAddress
    self.careerObjective = personalDetail.careerObjective
    self.yearsOfExperience = personalDetail.yearsOfExperience
    self.createdTs = personalDetail.createdTs
    self.isSaved = personalDetail.isSaved
    self.workSummary.append(objectsIn: personalDetail.workSummary)
    self.skillList.append(objectsIn: personalDetail.skillList)
    self.educationDetails.append(objectsIn: personalDetail.educationDetails)
    self.projectDetails.append(objectsIn: personalDetail.projectDetails)
  }
}

