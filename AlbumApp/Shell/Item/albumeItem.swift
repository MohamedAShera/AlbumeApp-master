//
//  albumeItem.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation

class albumeItem: BaseItem {
    
    var albumeId: Int
     var albumeTitle: String
    
    init(_ albumeId:Int , albumeTitle : String ) {
        self.albumeId = albumeId
        self.albumeTitle = albumeTitle
 
        
    }
}
