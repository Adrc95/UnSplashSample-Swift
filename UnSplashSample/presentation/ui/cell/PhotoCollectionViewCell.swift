//
//  PhotoCollectionViewCell.swift
//  UnSplashSample
//
//  Created by Adrian on 17/4/23.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!

    func bind(photo: Photo) {
        photoImageView.sd_setImage(with: photo.url)
    }
}
