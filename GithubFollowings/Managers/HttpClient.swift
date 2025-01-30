//
//  NetworkManager.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 18.02.2024.
//

import Foundation
import UIKit

let baseUrl = "https://api.github.com"

enum URLPaths: String {
  case users = "/users"
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

enum RequestError: Error {
  case badUrl
  case badModel
}

enum NetworkError: Error {
  case clientError
  case serverError
  case invalidResponse
  case unknown
  case badUrl
  case badModel
}

protocol NetworkProtocol {
  func processRequest<T:Decodable>(urRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class HttpClient2: NetworkProtocol {

  private let urlSession: URLSession
  private let jsonDecoder: JSONDecoder

  init(urlSession: URLSession = URLSession(configuration: .default), jsonDecoder: JSONDecoder = JSONDecoder()) {
    self.urlSession = urlSession
    self.jsonDecoder = jsonDecoder
  }

  func makeUrlRequest(baseUrl: URL,
                      path: String?,
                      httpMethod: HTTPMethod,
                      queryParameters: [String: String]?) -> URLRequest
  {
    var url = configureUrlPath(baseUrl: baseUrl, path: path)
    configureQueryItems(url: &url, queryParameters: queryParameters)

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.rawValue
    return urlRequest
  }

  internal func processRequest<T: Decodable>(urRequest urlRequest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {

    let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
      guard let self = self else { return }

      if let _ = error {
        completion(.failure(.unknown))
        return
      }

      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(.invalidResponse))
        return
      }

      guard let data = data else {
        completion(.failure(.invalidResponse))
        return
      }

      switch self.verifyResponse(data: data, response: httpResponse) {
      case .success(let validData):
        do {
          let decodedObject = try self.jsonDecoder.decode(T.self, from: validData)
          completion(.success(decodedObject))
        } catch {
          completion(.failure(.badModel))
        }
      case .failure(let networkError):
        completion(.failure(networkError))
      }
    }
    task.resume()
  }

  private func configureUrlPath(baseUrl: URL, path: String?) -> URL {
    var newUrl: URL
    if let path = path {
      newUrl = baseUrl.appending(path: path)
    } else {
      newUrl = baseUrl
    }
    return newUrl
  }

  private func configureQueryItems(url: inout URL, queryParameters: [String: String]?) {
    if let queryParameters = queryParameters {
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
      urlComponents?.queryItems = queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
      if let newUrl = urlComponents?.url {
        url = newUrl
      }
    }
  }

  private func verifyResponse(data: Data, response: URLResponse) -> Result<Data, NetworkError> {
    guard let httpResponse = response as? HTTPURLResponse else {
      return .failure(NetworkError.invalidResponse)
    }
    switch httpResponse.statusCode {
    case 200...299:
      return .success(data)
    case 400...499:
      return .failure(NetworkError.clientError)
    case 500...599:
      return .failure(NetworkError.serverError)
    default:
      return .failure(NetworkError.unknown)
    }
  }
}


class HttpClient {
  let networkerror = NetworkError2.self
  static let shared = HttpClient()
  let cache = NSCache<NSString, UIImage>()

  private init() {}

  func getFollowers(for userName: String, page: Int, completion: @escaping (Result<[Following],NetworkError2>) -> Void) {

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
