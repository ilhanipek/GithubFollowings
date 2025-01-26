//
//  Following.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 18.02.2024.
//

import Foundation

struct Following : Codable, Hashable {
  var login : String
  var avatarUrl : String 
}

extension Following {
  
  static let followingList : [Following] = [
    .init(login: "İlhan", avatarUrl: "wwwçcmdslfssfsfls"),
    .init(login: "sdkfsfsj", avatarUrl: "sdlkfjsf"),
    .init(login: "sdfsdf", avatarUrl: "sdfsdfsd")
  ]
}
