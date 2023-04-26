//
//  Endpoint.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation
import Alamofire

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding? { get }
}

extension Endpoint {
    var encoding: ParameterEncoding? {
        return JSONEncoding.default
    }
}
