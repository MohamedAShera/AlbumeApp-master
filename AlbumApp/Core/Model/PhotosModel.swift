//
//  PhotosModel.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation

// MARK: - PhotosModelElement
struct PhotosModel: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias photoModels = [PhotosModel]
