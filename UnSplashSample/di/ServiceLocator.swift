//
//  ServiceLocator.swift
//  UnSplashSample
//
//  Created by Adrian on 23/4/23.
//

import Foundation
import UIKit
import Alamofire

struct ServiceLocator {
    private func provideBaseUrl() -> String {
        return "https://api.unsplash.com/"
    }

    private func providesHeaderInterceptor() -> RequestInterceptor {
        return HeaderInterceptor()
    }

    private func provideApi() -> Api {
        return ApiManager(baseURL: provideBaseUrl(), requestInterceptor: providesHeaderInterceptor())
    }

    private func provideUnSplashService() -> UnSplashService {
        return UnSplashApi(api: provideApi())
    }

    private func provideRemoteDataSource() -> RemoteDataSource {
        return PhotosAlamoFireDataSource(apiService: provideUnSplashService())
    }

    private func providePhotoRepisitory() -> PhotoRepository {
        return PhotoRepository(remoteDataSource: provideRemoteDataSource())
    }

    private func provideGetPhotos() -> GetPhotos {
        return GetPhotos(photoRepository: providePhotoRepisitory())
    }

    private func provideGetPhoto() -> GetPhoto {
        return GetPhoto(photoRepository: providePhotoRepisitory())
    }

    private func provideMainViewModel() -> MainViewModel {
        return MainViewModel(getPhotos: provideGetPhotos())
    }

    private func provideDetailViewModel(id: String) -> DetailViewModel {
        return DetailViewModel(id: id, getPhoto: provideGetPhoto())
    }

    private func provideMainViewController() -> MainViewController {
        let mainViewController: MainViewController = storyboard.instantiateViewController("MainViewController")
        let mainViewModel = provideMainViewModel()
        let dataSource = providePhotoCollectionViewDataSource()
        let delegate = PhotoCollectionViewDelegate(dataSource: dataSource, viewModel: mainViewModel)
        mainViewController.viewModel = mainViewModel
        mainViewController.dataSource = dataSource
        mainViewController.delegate = delegate
        return mainViewController
    }

    func providesDetailViewController(_ id: String) -> DetailViewController {
        let detailViewController: DetailViewController = storyboard.instantiateViewController("DetailViewController")
        let detailViewModel = provideDetailViewModel(id: id)
        detailViewController.viewModel = detailViewModel
        return detailViewController
    }

    private func providePhotoCollectionViewDataSource() -> PhotoCollectionViewDataSource {
        return PhotoCollectionViewDataSource()
    }

    func providerRootViewController() -> UIViewController {
        let navigationController: UINavigationController = storyboard.initialViewController()
        navigationController.viewControllers = [provideMainViewController()]
        return navigationController
    }

    private var storyboard: Navigation = { return Navigation(name: "UnSplashSample") }()
}
