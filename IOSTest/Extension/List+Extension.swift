//
//  List+Extension.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 01/05/22.
//

import RealmSwift

extension List {
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
