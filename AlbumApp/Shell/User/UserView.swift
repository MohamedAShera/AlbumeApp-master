//
//  UserView.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//

import Foundation
import UIKit

class UserView: BaseView<UserPresenter, BaseItem> {
    
    @IBOutlet weak var albumesCollectionView: UICollectionView!{
        didSet {
            self.albumesCollectionView.register(UINib(nibName: String(describing: AlbumesCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AlbumesCell.self))

        }

    }
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var UserAddressLbl: UILabel!
    
    override func bindind() {
        presenter = UserPresenter(router: RouterManager(self), userRepo: UserRepoImpl())
        presenter.userName.bind(to: userNameLbl)
        presenter.userAdress.bind(to: UserAddressLbl)
        presenter.albumes.bind { (_) in
                    self.albumesCollectionView.reloadData()

        }

        presenter.getUserInfo()
        presenter.getAlbumes()

    }
    override func viewWillAppear(_ animated: Bool) {
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = "Profile"
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
            
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.black,
            ]
            
            navigationController?.navigationBar.largeTitleTextAttributes = attributes
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            // Play around with the duration until you find
            // a time interval, you find suitable
            UIView.animate(withDuration: 2) {
                self.navigationController?.navigationBar.isTranslucent = true
            }
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
}

extension UserView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     print("😁😁\(presenter.albumes.value.count)")
        return presenter.albumes.value.count
       
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumesCell.self), for: indexPath))  as! AlbumesCell
            cell.configure(result: presenter.albumes.value[indexPath.row], index: indexPath.row)
            return cell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.routeToDetails(albumeId: presenter.albumes.value[indexPath.row].id ?? 0, albumeTitle: presenter.albumes.value[indexPath.row].title ?? "")
      
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
            return CGSize( width: (collectionView.frame.width), height: 50 )

        
    }
    
}


