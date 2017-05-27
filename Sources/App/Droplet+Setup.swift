@_exported import Vapor

extension Droplet {
  public func setup() throws {
    _ = TrackerDataController(drop: self)
    
    let routes = Routes(view)
    try collection(routes)
  }
}
