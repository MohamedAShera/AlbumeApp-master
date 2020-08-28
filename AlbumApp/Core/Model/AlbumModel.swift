//
//  AlbumModel.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation

// MARK: - AlbumModelElement
struct AlbumModel: Codable {
    let userID, id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
typealias AlbumModels = [AlbumModel]

