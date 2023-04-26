//
//  PhotoCollectionViewDataSource.swift
//  UnSplashSample
//
//  Created by Adrian on 23/4/23.
//

import Foundation
import UIKit

class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    open var photos = [Photo]()

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.bind(photo: photo)
        return cell
    }
}
