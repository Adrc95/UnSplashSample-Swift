//
//  Api.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation

protocol Api {
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T
}
