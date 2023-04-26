//
//  UnsplashEndpoint.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation
import Alamofire

enum UnsplashEndpoint: Endpoint {
    case getPhotos(page: Int, perPage: Int)
    case getPhoto(id: String)

    var path: String {
        switch self {
        case .getPhotos:
            return "/photos"
        case .getPhoto(let id):
            return "/photos/\(id)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters? {
        switch self {
        case .getPhotos(let page, let perPage):
            return ["page": page, "per_page": perPage]
        default:
            return nil
        }
    }
}
