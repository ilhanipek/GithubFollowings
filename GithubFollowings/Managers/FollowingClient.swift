//
//  FollowingClient.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 30.01.2025.
//

import Foundation

protocol FollowingProtocol {
  func getFollowings(username: String, followingCountPerPage: Int, page: Int, completion: @escaping (Result<[Following], NetworkError>) -> Void)

  func getFollowingByUsername(followingUsername: String, completion: @escaping (Result<Following, NetworkError>) -> Void)
}

extension HttpClient: FollowingProtocol {
  func getFollowings(username: String, followingCountPerPage: Int, page: Int, completion: @escaping (Result<[Following], NetworkError>) -> Void) {
    guard let baseUrl = URL(string: baseUrl) else {
      completion(.failure(.badUrl))
      return
    }
    
    let urlRequest = makeUrlRequest(
      baseUrl: baseUrl,
      path: "\(URLPaths.users.rawValue)/\(username)/following",
      httpMethod: .get,
      queryParameters: [
        "per_page" : "\(followingCountPerPage)",
        "page"     : "\(page)"
      ]
    )
    processRequest(urlRequest: urlRequest, completion: completion)
  }

  func getFollowingByUsername(followingUsername: String, completion: @escaping (Result<Following, NetworkError>) -> Void) {
    guard let baseUrl = URL(string: baseUrl) else {
      completion(.failure(.badUrl))
      return
    }

    var urlRequest = makeUrlRequest(baseUrl: baseUrl,
                                    path: "\(URLPaths.users.rawValue)/\(followingUsername)",
                                    httpMethod: .get,
                                    queryParameters: nil)
    processRequest(urlRequest: urlRequest, completion: completion)
  }
}
