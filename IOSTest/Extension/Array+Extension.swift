//
//  Array+Extension.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 29/04/22.
//

extension Array {
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
