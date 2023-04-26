//
//  PhotoRepository.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

class PhotoRepository {
    private let remoteDataSource: RemoteDataSource

    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getPhoto(id: String) async throws -> Result<Photo, Error> {
        do {
            let result = try await remoteDataSource.getPhoto(id: id).get()
            return .success(result)
        } catch {
            return .failure(error)
      }
    }

    func getPhotos(page: Int, perPage: Int) async throws -> Result<[Photo], Error> {
      do {
        let result = try await remoteDataSource.getPhotos(page: page, perPage: perPage).get()
        return .success(result)
      } catch {
        return .failure(error)
      }
    }
}
