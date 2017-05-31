//
//  PromisesManager.swift
//  trump-tracker-vapor
//
//  Created by Louis Tur on 5/30/17.
//
//

import Foundation
import Vapor

// Is this not proper, should I be using fluent?
final class PromisesManager {
  private var promises: [Promise] = []
  
  static let manager: PromisesManager = PromisesManager()
  private init() {}
  
  func addPromise(_ promise: Promise) {
    self.promises.append(promise)
  }
  
  func addPromise(_ promises: [Promise]) {
    self.promises.append(contentsOf: promises)
  }
  
  func allPromises() -> [Promise] {
    return self.promises
  }
  
  func count() -> Int {
    return self.promises.count
  }
}
