//
//  User.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 18.02.2024.
//

import Foundation

struct User : Codable {
  let login : String
  let avatarUrl : String
  var name : String?
  var location : String?
  var bio : String?
  let publicRepos : Int
  let publicGists : Int
  let htmlUrl : String
  let followings : Int
  let followers : Int
  let createdAt : String
}
