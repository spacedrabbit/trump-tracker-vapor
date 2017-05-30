@_exported import Vapor

extension Droplet {
  public func setup() throws {
    let tracker = TrackerDataController(self)
    try tracker.requestInfo()
    
    let promiseController = PromisesViewController(view: view)
    promiseController.addRoutes(self)
    
    let routes = Routes(view)
    try collection(routes)
  }
}
