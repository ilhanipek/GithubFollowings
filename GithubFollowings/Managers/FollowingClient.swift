//
//  FollowingClient.swift
//  GithubFollowings
//
//  Created by ilhan serhan ipek on 30.01.2025.
//

import Foundation

protocol FollowingProtocol {
  func getFollowings(username: String ,completion: @escaping (Result<[Following], NetworkError>) -> Void)
}

extension HttpClient2: FollowingProtocol {
  func getFollowings(username: String, completion: @escaping (Result<[Following], NetworkError>) -> Void) {
    guard let baseUrl = URL(string: baseUrl) else {
      completion(.failure(.badUrl))
      return
    }
    
    let urlRequest = makeUrlRequest(
      baseUrl: baseUrl,
      path: "\(URLPaths.users.rawValue)",
      httpMethod: .get,
      queryParameters: nil
    )
    
    processRequest(urRequest: urlRequest, completion: completion)
  }
}
