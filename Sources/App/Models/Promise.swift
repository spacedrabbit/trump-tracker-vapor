//
//  Promises.swift
//  trump-tracker-vapor
//
//  Created by Louis Tur on 5/30/17.
//
//

import Foundation
import Vapor

enum PromiseStatus {
  case notStarted, inProgress, achieved, broken, compromised, unknown
  
  init(status: String) {
    switch status {
    case kStatusNotStarted: self = .notStarted
    case kStatusInProgress: self = .inProgress
    case kStatusAcheived: self = .achieved
    case kStatusBroken: self = .broken
    case kStatusCompromised: self = .compromised
    default: self = .unknown
    }
  }
  
  func key() -> String {
    switch self {
    case .notStarted: return kStatusNotStarted
    case .inProgress: return kStatusInProgress
    case .achieved: return kStatusAcheived
    case .broken: return kStatusBroken
    case .compromised: return kStatusCompromised
    default: return "Unknown"
    }
  }
}

enum PromiseCategory: String {
  case  first100Days, culture, economy,
        environment, government, immigration,
        indigenous, security, health, world,
        education, unknown
  
  init(category: String) {
    switch category {
    case kCategoryFirst100Days: self = .first100Days
    case kCategoryCulture: self = .culture
    case kCategoryEconomy: self = .economy
    case kCategoryEnvironment: self = .environment
    case kCategoryGovernment: self = .government
    case kCategoryImmigration: self = .immigration
    case kCategoryIndigenous: self = .indigenous
    case kCategorySecurity: self = .security
    case kCategoryHealth: self = .health
    case kCategoryWorld: self = .world
    case kCategoryEducation: self = .education
    default: self = .unknown
    }
  }
  
  func key() -> String {
    switch self {
    case .first100Days: return kCategoryFirst100Days
    case .culture: return kCategoryCulture
    case .economy: return kCategoryEconomy
    case .environment: return kCategoryEnvironment
    case .government: return kCategoryGovernment
    case .immigration: return kCategoryImmigration
    case .indigenous: return kCategoryIndigenous
    case .security: return kCategorySecurity
    case .health: return kCategoryHealth
    case .world: return kCategoryWorld
    case .education: return kCategoryEducation
    default: return "Unknown"
    }
  }
}

final class Promise {
  let title: String
  let description: String
  let url: String
  let status: PromiseStatus
  let statusInfo: String
  let category: PromiseCategory
  let tags: [String]
  let comments: [String]
  let sources: [String]
  
  init(title: String, description: String, url: String,
       status: String, statusInfo: String, category: String,
       tags: [String], comments: [String], sources: [String]) {
    
    self.title = title
    self.description = description
    self.url = url
    self.status = PromiseStatus(status: status)
    self.statusInfo = statusInfo
    self.category = PromiseCategory(category: category)
    self.tags = tags
    self.comments = comments
    self.sources = sources
  }
}


// MARK: - Node Conversion
extension Promise: NodeConvertible {
  
  convenience init(node: Node) throws {
    try self.init(json: JSON(node: node))
  }
  
  func makeNode(in context: Context?) throws -> Node {
    return try Node(node: [
                            kTitle : self.title,
                            kDescription : self.description,
                            kURL : self.url,
                            kStatus : self.status.key(),
                            kStatusInfo : self.statusInfo,
                            kCategory : self.category.key(),
                            kTags : self.tags,
                            kComments : self.comments,
                            kSources : self.sources
      ])
  }
}


// MARK: - JSON Conversion
extension Promise: JSONConvertible {
  
  convenience init(json: JSON) throws {
    guard
      let title = json[kTitle]?.string,
      let description = json[kDescription]?.string,
      let url = json[kURL]?.string,
      let status = json[kStatus]?.string,
      let statusInfo = json[kStatusInfo]?.string,
      let category = json[kCategory]?.string,
      let tags = json[kTags]?.array,
      let comments = json[kComments]?.array,
      let sources = json[kSources]?.array
      else {
        throw Abort.init(.other(statusCode: 900, reasonPhrase: "Could not create Promises"))
    }
    
    self.init(title: title,
              description: description,
              url: url,
              status: status,
              statusInfo: statusInfo,
              category: category,
              tags: tags.flatMap{ $0.string },
              comments: comments.flatMap{ $0.string },
              sources: sources.flatMap{ $0.string })
  }
  
  func makeJSON() throws -> JSON {
    return try JSON(node: self)
  }
}
