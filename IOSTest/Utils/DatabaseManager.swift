//
//  DatabaseManager.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

import RealmSwift

class DatabaseManager {
  static let realmSchemaVersion: UInt64 = 1

  class func start() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
      schemaVersion: realmSchemaVersion,
      migrationBlock: { migration, oldSchemaVersion in
        if oldSchemaVersion < self.realmSchemaVersion {
          // Do your migration if have
        }
      }
    )
  }
}
