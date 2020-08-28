//
//  PhotosProcessor.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation
import Promises
class PhotosProcessor:  NetworkProcessor<photoModels>  {
    var userRepo: UserRepo
    var albumeId: Int
    
    init(userRepo: UserRepo, albumeId: Int) {
        self.userRepo = userRepo
        self.albumeId = albumeId
        
    }
    
    override func extract() {}
    
    override func validate() throws {
    }
    
    override func process() throws -> Promise<photoModels> {
        return userRepo.getPhotos(albumId: albumeId)
        
    }
}
