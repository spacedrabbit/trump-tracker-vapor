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
    let notStarted = PromisesManager.manager.promises(status: .notStarted).count
    let broken = PromisesManager.manager.promises(status: .broken).count
    let inProgress = PromisesManager.manager.promises(status: .inProgress).count
    let achieved = PromisesManager.manager.promises(status: .achieved).count
    let compromised = PromisesManager.manager.promises(status: .compromised).count
    
    return try self.view.make("welcome", ["promises" : PromisesManager.manager.allPromises(),
                                          "total_promises" : PromisesManager.manager.count(),
                                          "not_started" : notStarted,
                                          "in_progress" : inProgress,
                                          "acheived" : achieved,
                                          "broken" : broken,
                                          "compromised" : compromised
      ])
  }
  
}
