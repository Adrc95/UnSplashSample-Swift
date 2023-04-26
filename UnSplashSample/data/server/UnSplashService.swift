//
//  UnSplashService.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

protocol UnSplashService {
    func getPhotos(page: Int, perPage: Int) async throws -> Result<[PhotoDto], Error>
    func getPhoto(id: String) async throws -> Result<PhotoDto, Error>
}
