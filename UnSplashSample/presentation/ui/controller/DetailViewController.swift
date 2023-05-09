//
//  DetailViewController.swift
//  UnSplashSample
//
//  Created by Adrian on 26/4/23.
//

import UIKit
import SDWebImage
import Combine

class DetailViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    private var cancellables = Set<AnyCancellable>()
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        collectState()
    }

    private func collectState() {
        viewModel.$state.sink { [weak self] state in
            self?.updateUI(state: state)
        }.store(in: &cancellables)
    }

    private func updateUI(state: DetailViewModel.UIState) {
        updateLoading(isRenderLoading: state.isLoading)
        updateUI(detail: state.photo)
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

    private func showError(isError: Bool) {
        if isError {
            showDialog()
        }
    }

    private func updateUI(detail: Photo?) {
        updatePhoto(photo: detail?.url)
        updateAuthor(detail: detail)
    }

    private func updateAuthor(detail: Photo?) {
        name.text = detail?.author.name
        username.text = detail?.author.username
        detail?.author.photo.let { photo in
            avatar.sd_setImage(with: photo)
            avatar.layer.cornerRadius = 20
            avatar.clipsToBounds = true
        }
    }

    private func updatePhoto(photo: URL?) {
        photo.let { photo in
            photoImageView.sd_setImage(with: photo)
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

    private func changeTitle(title: String) {
        navigationItem.title = title
    }
}
