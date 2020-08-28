//
//  AlbumeView.swift
//  AlbumApp
//
//  Created by mohamed on 8/23/20.
//  Copyright © 2020 mohamed. All rights reserved.
//


import Foundation
import UIKit

class PhotosView: BaseView<PhotosPresenter, albumeItem> {
    
    @IBOutlet weak var SearchTab: UISearchBar!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!{
           didSet {
               self.photosCollectionView.register(UINib(nibName: String(describing: PhotosCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PhotosCell.self))

           }

       }
    var timer: Timer!

    override func bindind() {
        presenter = PhotosPresenter(router: RouterManager(self), userRepo: UserRepoImpl(), item: item)
        presenter.photos.bind { (_) in
                    self.photosCollectionView.reloadData()

        }
        self.navigationItem.title = self.presenter.albumeTitle.value

      self.SearchTab.endEditing(true)

        presenter.getPhotos()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = "Profile"
            self.navigationItem.backBarButtonItem?.title = "Profile"

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

extension PhotosView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos.value.count
       
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCell.self), for: indexPath))  as! PhotosCell
            cell.configure(result: presenter.photos.value[indexPath.row], index: indexPath.row)
            return cell
        
        
        
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
extension PhotosView : UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()

    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        startTimer(searchQuery: searchText)
    }
    private func startTimer(searchQuery: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ApplySearch), userInfo: ["SearchQuery": searchQuery], repeats: false)
    }
    @objc private func ApplySearch() {
        if  let userInfo = timer.userInfo as? [String: String],
            let searchQuery = userInfo["SearchQuery"] {
            applySearchOnViews(searchQuery: searchQuery)
        }
    }
    
    
    
    
    func applySearchOnViews(searchQuery: String){
        self.presenter.photos.value = searchQuery == "" ? self.presenter.fullPhotos.value : self.presenter.photos.value.filter{
            (service) -> Bool in
            return service.title?.localizedCaseInsensitiveContains(searchQuery) ?? true 
        }
        photosCollectionView.reloadData()
    }
}
