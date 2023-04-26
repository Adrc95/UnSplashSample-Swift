//
//  MainViewController.swift
//  UnSplashSample
//
//  Created by Adrian on 17/4/23.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    private var cancellables = Set<AnyCancellable>()

    var dataSource: PhotoCollectionViewDataSource!

    var delegate: PhotoCollectionViewDelegate!

    var viewModel: MainViewModel!

    override func viewDidLoad() {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        let nibCell = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "cell")
        configureTitle()
        configureNavigationBarBackButton()
        super.viewDidLoad()
        viewModel.viewDidLoad()
        collectState()
        collectEvents()
    }

    private func collectState() {
        viewModel.$state.sink { [weak self] state in
            self?.updateUI(state: state)
        }.store(in: &cancellables)
    }

    private func collectEvents() {
        viewModel.$events.sink { [weak self] event in
            switch event {
            case .onItemClick(let photo):
                self?.navigateToDetail(photoSelected: photo)
            case .none: break
            }
        }.store(in: &cancellables)
    }

    private func updateUI(state: MainViewModel.UIState) {
        updateLoading(isRenderLoading: state.isLoading)
        updatePhotoCollection(photos: state.photos)
        showError(isError: state.error)
    }

    private func updateLoading(isRenderLoading: Bool) {
        switch isRenderLoading {
        case true:
            showLoading()
        case false:
            hideLoading()
        }
    }

    private func showLoading() {
        loading.startAnimating()
    }

    private func hideLoading() {
        loading.stopAnimating()
    }

    private func updatePhotoCollection(photos: [Photo]) {
        dataSource.photos = photos
        collectionView.reloadData()
    }

    private func navigateToDetail(photoSelected: Photo) {
        let detailViewController = ServiceLocator().providesDetailViewController(photoSelected.id)
        navigationController?.pushViewController(detailViewController, animated: true)
        viewModel.resetPhotoSelected()
    }

    private func configureTitle() {
        navigationItem.title = "app_name".getString()
    }

    private func showError(isError: Bool) {
        if isError {
            showDialog()
        }
    }

    private func showDialog() {
        let alertController = UIAlertController(title: "error".getString(), message: "error_message".getString(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "retry".getString(), style: .default) { _ in
            self.viewModel.onRetry()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    private func configureNavigationBarBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
