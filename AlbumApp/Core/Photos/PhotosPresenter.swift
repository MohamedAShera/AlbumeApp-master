//
//  PhotosPresenter.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation
import UIKit
import Bond

class PhotosPresenter: BasePresenter {
    
    var router: RouterManagerProtocol
    let albumeId: Observable<String?> = Observable("")
    let albumePhoto: Observable<String?> = Observable("")
    let albumeTitle: Observable<String?> = Observable("")
    var item: albumeItem
    var photos: Dynamic<[PhotosModel]> = Dynamic([])
    var fullPhotos: Dynamic<[PhotosModel]> = Dynamic([])

    let userRepo: UserRepo
    
    init(router: RouterManagerProtocol, userRepo: UserRepo , item : albumeItem) {
        self.router = router
        self.userRepo = userRepo
        self.item = item
        
    }
    
    override func hydrate() {
        self.albumeTitle.value = self.item.albumeTitle

    }
 
    func getPhotos(){
          showLoading()
        PhotosProcessor(userRepo: userRepo, albumeId: item.albumeId).execute()
              .then { (response) in
                self.photos.value = response
                self.fullPhotos.value = response
                  self.hideLoading()

                  
          }.catch { (error) in
              self.hideLoading()
              self.showSystemError(error: error)}
      }
}
