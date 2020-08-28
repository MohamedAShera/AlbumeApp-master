//
//  Endpoint.swift
//  FourSqaureSample
//
//  Created by mohamed on 7/8/20.
//  Copyright © 2020 mohamed. All rights reserved.
//


import Foundation

protocol Endpoint {
    var service: EndpointService {get set}
    var url: String {get set}
    var method: EndpointMethod {get set}
    var auth: AuthorizationHandler {get set}
    var parameters: [String: Any] {get set}
    var encoding: EndpointEncoding {get set}
    var headers: [String: String] {get set}
}

enum EndpointEncoding {
    case json
    case query
}

enum EndpointMethod: String {
    case get
    case post
    case put
    case delete
}

enum EndpointService {
    case users
    case albums
    case photos
  
    var url: String {
       
        return "https://jsonplaceholder.typicode.com/\(self)"
    }
    
}
