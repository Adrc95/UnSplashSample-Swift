//
//  MainViewModel.swift
//  UnSplashSample
//
//  Created by Adrian on 17/4/23.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var state: UIState = UIState()
    @Published var events: UIEvents = UIEvents.none

    private let getPhotos: GetPhotos

    private var page = 0

    init(getPhotos: GetPhotos) {
        self.getPhotos = getPhotos
    }

    func viewDidLoad() {
        callGetPhotos()
    }

    private func callGetPhotos() {
        state.isLoading = true
        Task.init {
            let responseSource = try await getPhotos.getPhotos(page: page, perPage: itemPerPage)
            DispatchQueue.main.async {
              switch responseSource {
              case .failure:
                  self.state = UIState(error: true)
              case .success(let list):
                  self.state.isLoading = false
                  self.state.error = false
                  self.state.photos += list
              }
            }
        }
    }

    func loadMore() {
        page += 1
        callGetPhotos()
    }

    func onItemClick(photo: Photo) {
        events = UIEvents.onItemClick(photo: photo)
    }

    func resetPhotoSelected() {
        events = UIEvents.none
    }

    func onRetry() {
        callGetPhotos()
    }

    struct UIState {
        var photos: [Photo] = []
        var isLoading = false
        var error: Bool = false
    }

    enum UIEvents {
        case onItemClick(photo: Photo)
        case none
    }
}
