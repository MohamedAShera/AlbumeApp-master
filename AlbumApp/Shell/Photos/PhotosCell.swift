//
//  PhotosCell.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import UIKit
import moa
class PhotosCell: UICollectionViewCell {
    var itemIndex: Int = 0
    @IBOutlet weak var img: UIImageView!
     func configure(result: PhotosModel, index: Int) {
         self.itemIndex = index
        img.moa.url = result.url

     }

  
}
