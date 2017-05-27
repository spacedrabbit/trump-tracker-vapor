//
//  TrackerDataController.swift
//  trump-tracker-vapor
//
//  Created by Louis Tur on 5/27/17.
//
//

import Foundation
import Vapor
import HTTP

final class TrackerDataController: DropletInitializable {
  private let dataURL: String = "https://raw.githubusercontent.com/TrumpTracker/trumptracker.github.io/master/_data/data.json"
  let drop: Droplet!
  
  init(_ drop: Droplet) {
    self.drop = drop
    self.addRoutes(self.drop)
  }
  
  private func addRoutes(_ drop: Droplet) {
    drop.get("/data", handler: getData)
  }
  
  func getData(request: Request) throws -> ResponseRepresentable {
    let dataResponse: Response = try self.drop.client.get(dataURL)
    guard
      let bodyData: Bytes = dataResponse.body.bytes,
      let json: JSON = try? JSON(bytes: bodyData) else {
        throw Abort.badRequest
    }
    
    return json
  }
}
