//
//  Networking.swift
//  RMUIChallenge
//
//  Copyright © 2020 com.adt.myadtmobileenterprise. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  
  // MARK: - Cases
  
  case badURL
  case noData
  case parsingFailed
}


final class NetworkManager {
  
  // MARK: - Static Properties
  
  static let shared = NetworkManager()
  
  // MARK: - Properties
  
  private let baseURL = "https://rickandmortyapi.com/api/character/"
  
  private init() { }
  
  // MARK: - Public Methods
  
  func fetchCharacters(page: Int?, completion: @escaping (Result<[CharacterModel], NetworkError>) -> Void) {
    guard let url = URL(string: baseURL) else {
      completion(.failure(.badURL))
      return
    }
    
    var request = URLRequest(url: url)
    if let page = page {
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
      urlComponents?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
      request.url = urlComponents?.url
    }
    
    let session = URLSession.shared
    
    session.dataTask(with: request) { data, response, error in
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      guard let result = try? JSONDecoder().decode(CharactersResponse.self, from: data),
        let characters = result.results else {
          completion(.failure(.parsingFailed))
          return
      }
      
      completion(.success(characters))
      
    }.resume()
  }
}
