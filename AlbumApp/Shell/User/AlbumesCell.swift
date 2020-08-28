//
//  AlbumesCell.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import UIKit

class AlbumesCell: UICollectionViewCell {
    var itemIndex: Int = 0
    @IBOutlet weak var albumeTitellabel: UILabel!
    func configure(result: AlbumModel, index: Int) {
        self.itemIndex = index
        albumeTitellabel.text = result.title
    }

}
