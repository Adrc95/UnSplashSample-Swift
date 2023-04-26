//
//  DetailViewModel.swift
//  UnSplashSample
//
//  Created by Adrian on 26/4/23.
//

import Foundation

class DetailViewModel: ObservableObject {

    @Published var state: UIState = UIState()

    private let id: String
    private let getPhoto: GetPhoto

    init(id: String, getPhoto: GetPhoto) {
        self.id = id
        self.getPhoto = getPhoto
    }

    func viewDidLoad() {
        callGetPhoto()
    }

    func onRetry() {
        callGetPhoto()
    }

    private func callGetPhoto() {
        state.isLoading = true
        Task.init {
            let responseSource = try await getPhoto.getPhoto(id: id)
            DispatchQueue.main.async {
              switch responseSource {
              case .failure:
                  self.state = UIState(error: true)
              case .success(let photo):
                  self.state = UIState(photo: photo)
              }
            }
        }
    }

    struct UIState {
        var photo: Photo?
        var isLoading: Bool = false
        var error: Bool = false
    }

}
