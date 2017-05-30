@_exported import Vapor

extension Droplet {
  public func setup() throws {
    let tracker = TrackerDataController(self)
    tracker.requestInfo()
    
    
    let routes = Routes(view)
    try collection(routes)
  }
}
