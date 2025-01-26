//
//  NetworkManager.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 18.02.2024.
//

import Foundation
import UIKit

class NetworkManager {

  static let shared = NetworkManager()
  let baseUrl = "https://api.github.com"
  let cache = NSCache<NSString, UIImage>()

  private init() {}

  func getFollowers(for userName: String, page: Int, completion: @escaping (Result<[Following],NetworkError>) -> Void) {
    
    let endPoint = baseUrl + "/users/\(userName)/following?per_page=12&page=\(page)"

    guard let url = URL(string: endPoint) else {
      completion(.failure(.badUrl))
      return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in

      if let error = error {
        completion(.failure(.error))
      }

      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completion(.failure(.badResponse))
        return
      }
      print(url)
      if let data = data {
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          let data = try decoder.decode([Following].self, from: data)
          completion(.success(data))
        }catch {
          completion(.failure(.badData))
          return
        }
      }
    }
    .resume()
  }
  
}


