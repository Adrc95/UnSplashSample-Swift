//
//  UnSplashApi.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation
import Alamofire

class UnSplashApi: UnSplashService {

    let api: Api

    init(api: Api) {
        self.api = api
    }

    func getPhotos(page: Int, perPage: Int) async throws -> Result<[PhotoDto], Error> {
        do {
            let photos: [PhotoDto] = try await api.request(UnsplashEndpoint.getPhotos(page: page, perPage: perPage), responseType: [PhotoDto].self)
            return .success(photos)
        } catch {
            return .failure(error)
      }
    }

    func getPhoto(id: String) async throws -> Result<PhotoDto, Error> {
        do {
            let photo: PhotoDto = try await api.request(UnsplashEndpoint.getPhoto(id: id), responseType: PhotoDto.self)
            return .success(photo)
        } catch {
            return .failure(error)
      }
    }
}
