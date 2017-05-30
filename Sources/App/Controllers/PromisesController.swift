//
//  PromisesController.swift
//  trump-tracker-vapor
//
//  Created by Louis Tur on 5/30/17.
//
//

import Foundation
import Vapor

final class PromisesViewController {
  private let view: ViewRenderer
  
  init(view: ViewRenderer) {
    self.view = view
  }
  
  func addRoutes(_ drop: Droplet) {
    drop.get("", handler: index)
  }
  
  func index(_ request: Request) throws -> ResponseRepresentable {
    return try self.view.make("welcome", ["promises" : PromisesManager.manager.allPromises()])
    //return try JSON(node: PromisesManager.manager.allPromises())
  }
  
}
