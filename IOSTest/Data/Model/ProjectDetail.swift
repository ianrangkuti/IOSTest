//
//  ProjectDetail.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import RealmSwift

class ProjectDetail: Object {
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var projectName: String = ""
  @objc dynamic var teamSize: String = ""
  @objc dynamic var projectSummary: String = ""
  @objc dynamic var technologyUsed: String = ""
  @objc dynamic var role: String = ""
  @objc dynamic var createdTs: Int64 = Int64(Date().timeIntervalSince1970 * 1000)
}
