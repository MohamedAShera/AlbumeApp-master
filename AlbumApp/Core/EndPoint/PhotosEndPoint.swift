//
//  PhotosEndPoint.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation


class PhotosEndPoint: Endpoint {
    var service: EndpointService = .photos
    
    var url: String = ""
    
    var method: EndpointMethod = .get
    
    var auth: AuthorizationHandler = NoneAuthorizationHandler()
    
    var parameters: [String: Any] = [:]
    
    var encoding: EndpointEncoding = .query
    
    var headers: [String: String] = [:]
    init(albumeId : Int) {
             parameters = ["albumId": albumeId]
         }
    
}





