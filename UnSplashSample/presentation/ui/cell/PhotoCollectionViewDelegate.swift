//
//  PhotoCollectionViewDelegate.swift
//  UnSplashSample
//
//  Created by Adrian on 23/4/23.
//

import Foundation
import UIKit

class PhotoCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    let dataSource: PhotoCollectionViewDataSource
    let viewModel: MainViewModel

    init(dataSource: PhotoCollectionViewDataSource, viewModel: MainViewModel) {
        self.dataSource = dataSource
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.photos[indexPath.item]
        viewModel.onItemClick(photo: item)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight  - height {
            viewModel.loadMore()
        }
    }
}
