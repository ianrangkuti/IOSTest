//
//  Observable.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

class Observable<T> {
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  typealias Listener = (T) -> Void
  private var listener: Listener?
  
  init(_ value: T) {
    self.value = value
  }
  
  func bind(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
