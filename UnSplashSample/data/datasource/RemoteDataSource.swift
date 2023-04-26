//
//  RemoteDataSource.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

protocol RemoteDataSource {
    func getPhotos(page: Int, perPage: Int) async throws -> Result<[Photo], Error>
    func getPhoto(id: String) async throws -> Result<Photo, Error>
}
