//
//  CharacterModel.swift
//  RMUIChallenge
//
//  Copyright © 2020 com.adt.myadtmobileenterprise. All rights reserved.
//

import Foundation

enum CharacterStatus: String {
  
  // MARK: - Cases
  
  case alive
  case dead
  case unknown
}

enum CharacterGender: String {
  
  // MARK: - Cases

  case female
  case male
  case genderless
  case unknown
}

struct CharactersResponse: Decodable {
  
  // MARK: - Properties

  var info: CharactersInfo?
  var results: [CharacterModel]?
}

struct CharactersInfo: Decodable {
  
  // MARK: - Properties

  var count: Int?
  var pages: Int?
  var next: String?
  var prev: String?
}

struct CharacterModel: Decodable, Hashable {
  
  // MARK: - Properties
  
  let id: Int?
  let name: String?
  let status: CharacterStatus?
  let species: String?
  let type: String?
  let gender: CharacterGender?
  let origin: String?
  let location: String?
  let image: URL?
  let episodes: [URL]?
  
  enum CodingKeys: String, CodingKey {
    
    // MARK: - Cases
    
    case id, name, status, species, type, gender, origin, location, image
    case episodes = "episode"
  }
  
  // MARK: - Initializer
  
  init(from decoder: Decoder) throws {
    let container = try? decoder.container(keyedBy: CodingKeys.self)
    self.id = try? container?.decode(Int.self, forKey: .id)
    self.name = try? container?.decode(String.self, forKey: .name)
    self.species = try? container?.decode(String.self, forKey: .species)
    self.type = try? container?.decode(String.self, forKey: .type)
    self.origin = try? container?.decode(String.self, forKey: .origin)
    self.location = try? container?.decode(String.self, forKey: .location)
    
    let statusStr = try? container?.decode(String.self, forKey: .status)
    let genderStr = try? container?.decode(String.self, forKey: .gender)
    
    self.status = Helper.set(with: statusStr)
    self.gender = Helper.set(with: genderStr)
    
    if let imgURLStr = try? container?.decode(String.self, forKey: .image), let imgURL = URL(string: imgURLStr) {
      self.image = imgURL
    } else {
      self.image = nil
    }
    
    if let epStrings = try? container?.decode([String].self, forKey: .episodes) {
      let epURLs = epStrings.compactMap { URL(string: $0) }
      self.episodes = epURLs
    } else {
      self.episodes = nil
    }
  }
}
