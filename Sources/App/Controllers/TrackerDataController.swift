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
  
  func requestInfo() throws {
    //do {
      let response: Response = try self.drop.get("/data")
      guard
        let json = response.json,
        let promisesJSON = json["promises"]?.array
      else {
        throw Abort.init(.other(statusCode: 901, reasonPhrase: "Request from API failed"))
      }
      
      PromisesManager.manager.addPromise(
        try promisesJSON.flatMap(Promise.init(json:))
      )
      //PromisesManager.manager.allPromises().map{ print($0.title) }
    //}
  //catch {
  //  print("Error")
  //}
  }
}
