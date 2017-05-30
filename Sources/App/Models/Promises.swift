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

final class Promises {
  let title: String
  let description: String
  let url: String
  let status: String
  let statusInfo: String
  let category: String
  let tags: [String]
  let comments: [String]
  let sources: [String]
  
  init?(json: JSON) throws {

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
    
    self.title = title
    self.description = description
    self.url = url
    self.status = status
    self.statusInfo = statusInfo
    self.category = category
    self.tags = tags.flatMap{ $0.string }
    self.comments = comments.flatMap{ $0.string }
    self.sources = sources.flatMap{ $0.string }
  }
  
  
  
}
