//
//  AlbumResponse.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation

// MARK: - AlbumResponse
struct AlbumResponseItem: Codable {
  let userID, id: Int
  let title: String

  enum CodingKeys: String, CodingKey {
      case userID = "userId"
      case id, title
  }
}

typealias AlbumResponse = [AlbumResponseItem]
