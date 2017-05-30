//
//  Promises.swift
//  trump-tracker-vapor
//
//  Created by Louis Tur on 5/30/17.
//
//

import Foundation
import Vapor

let kTitle: String = "title"
let kDescription: String = "description"
let kURL: String = "url"
let kStatus: String = "status"
let kStatusInfo: String = "status_info"
let kCategory: String = "category"
let kTags: String = "tags"
let kComments: String = "comments"
let kSources: String = "sources"

final class Promise {
  let title: String
  let description: String
  let url: String
  let status: String
  let statusInfo: String
  let category: String
  let tags: [String]
  let comments: [String]
  let sources: [String]
  
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
    
    /*
    self.title = title
    self.description = description
    self.url = url
    self.status = status
    self.statusInfo = statusInfo
    self.category = category
    self.tags = tags.flatMap{ $0.string }
    self.comments = comments.flatMap{ $0.string }
    self.sources = sources.flatMap{ $0.string }
 */
  }
  
  init(title: String, description: String, url: String,
       status: String, statusInfo: String, category: String,
       tags: [String], comments: [String], sources: [String]) {
    
    self.title = title
    self.description = description
    self.url = url
    self.status = status
    self.statusInfo = statusInfo
    self.category = category
    self.tags = tags
    self.comments = comments
    self.sources = sources
  }
}

extension Promise: NodeConvertible {
  
  convenience init(node: Node) throws {
    try self.init(json: JSON(node: node))
  }
  
  func makeNode(in context: Context?) throws -> Node {
    return try Node(node: [
                            kTitle : self.title,
                            kDescription : self.description,
                            kURL : self.url,
                            kStatus : self.status,
                            kStatusInfo : self.statusInfo,
                            kCategory : self.category,
                            kTags : self.tags,
                            kComments : self.comments,
                            kSources : self.sources
      ])
  }
  
}
