//
//  UserPresenter.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import UIKit
import Bond

class UserPresenter: BasePresenter {
    
    var router: RouterManagerProtocol
    let userName: Observable<String?> = Observable("")
    let userAdress: Observable<String?> = Observable("")


    var albumes: Dynamic<[AlbumModel]> = Dynamic([])
    let albumeTitle: Observable<String?> = Observable("")
    let albumeId: Observable<String?> = Observable("")
    let userRepo: UserRepo
    
    init(router: RouterManagerProtocol, userRepo: UserRepo) {
        self.router = router
        self.userRepo = userRepo
        
    }
    
    override func hydrate() {
        getAlbumes()
    }
    func routeToDetails(albumeId:Int , albumeTitle : String) {
        router.push(view: .photosView, presenter: PhotosPresenter.self, item: albumeItem(albumeId, albumeTitle: albumeTitle))
       }
    func getUserInfo(){
        showLoading()
        UserProcessor(userRepo: userRepo).execute()
            .then { (response) in
                
                self.hideLoading()
                self.userName.value = response.name
                self.userAdress.value = "\(response.address?.street ?? "") ,\(response.address?.suite ?? "") , \(response.address?.city ?? "") , \(response.address?.zipcode ?? "") "

                
        }.catch { (error) in
            self.hideLoading()
            self.showSystemError(error: error)}
    }
    
    func getAlbumes(){
          showLoading()
          AlbumeProcessor(userRepo: userRepo).execute()
              .then { (response) in
                  
                  self.hideLoading()
                self.albumes.value = response

                  
          }.catch { (error) in
              self.hideLoading()
              self.showSystemError(error: error)}
      }
    
}
