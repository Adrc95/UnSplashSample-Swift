//
//  GetPhotos.swift
//  UnSplashSample
//
//  Created by Adrian on 20/4/23.
//

import Foundation

class GetPhotos {

    private let photoRepository: PhotoRepository

    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }

    func getPhotos(page: Int, perPage: Int) async throws -> Result<[Photo], Error> {
        return try await photoRepository.getPhotos(page: page, perPage: perPage)
    }
}
