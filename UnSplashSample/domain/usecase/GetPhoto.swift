//
//  GetPhoto.swift
//  UnSplashSample
//
//  Created by Adrian on 26/4/23.
//

import Foundation

class GetPhoto {

    private let photoRepository: PhotoRepository

    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }

    func getPhoto(id: String) async throws -> Result<Photo, Error> {
        return try await photoRepository.getPhoto(id: id)
    }
}
