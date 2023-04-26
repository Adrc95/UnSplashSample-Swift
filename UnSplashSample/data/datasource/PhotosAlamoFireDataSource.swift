//
//  PhotosAlamoFireDataSource.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

class PhotosAlamoFireDataSource: RemoteDataSource {
    var apiService: UnSplashService

    init(apiService: UnSplashService) {
        self.apiService = apiService
    }

    func getPhoto(id: String) async throws -> Result<Photo, Error> {
        do {
            let result = try await apiService.getPhoto(id: id).get()
            let photo = Photo(dto: result)
            return .success(photo)
        } catch {
            return .failure(error)
      }
    }

    func getPhotos(page: Int, perPage: Int) async throws -> Result<[Photo], Error> {
      do {
        let result = try await apiService.getPhotos(page: page, perPage: perPage).get()
        let photos: [Photo] = result.map { Photo(dto: $0) }
        return .success(photos)
      } catch {
        return .failure(error)
      }
    }
}
