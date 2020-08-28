//
//  UserRepoImpl.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation
import Promises

class UserRepoImpl: UserRepo {
    
    
    
    private var network: NetworkService
    private var localData: LocalData
    
    init(network: NetworkService = NetworkServiceImpl(), localData: LocalData = LocalDataImpl()) {
        self.network = network
        self.localData = localData
    }
    func getUserInfo() -> Promise<UserModel> {
        network.callModel(UserModel.self, endpoint: UserEndPoint())
    }
    func getAlbumes() -> Promise<AlbumModels> {
        network.callModel(AlbumModels.self, endpoint: AlbumesEndPoint())
    }
    
    func getPhotos(albumId: Int) -> Promise<photoModels> {
        network.callModel(photoModels.self, endpoint: PhotosEndPoint(albumeId: albumId))
    }

}
