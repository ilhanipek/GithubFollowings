//
//  User.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 18.02.2024.
//

import Foundation

struct User : Codable {
  var login : String
  var avatarUrl : String
  var name : String?
  var location : String?
  var bio : String?
  var publicRepos : Int
  var publicGists : Int
  var htmlUrl : String
  var followings : Int
  var followers : Int
  var createdAt : String
}
