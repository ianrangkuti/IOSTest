//
//  WorkSummary.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import RealmSwift

class WorkSummary: Object {
  @objc dynamic var id: String = UUID().uuidString
  @objc dynamic var companyName: String = ""
  @objc dynamic var workDuration: String = ""
  @objc dynamic var createdTs: Int64 = Int64(Date().timeIntervalSince1970 * 1000)
}
