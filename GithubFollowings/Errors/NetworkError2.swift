//
//  NetworkError.swift
//  UIKITAPP
//
//  Created by ilhan serhan ipek on 19.02.2024.
//

import Foundation

enum NetworkError2 : Error {
  case badUrl
  case error
  case badResponse
  case badData

  var errorMessage : String {
    switch self {
    case .badUrl:
      return "This url is not valid"
    case .badResponse:
      return "Response error"
    case .error:
      return "Some error" 
    case .badData:
      return "Data error"
    }
  }
}


