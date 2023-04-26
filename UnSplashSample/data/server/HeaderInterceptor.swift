//
//  HeaderInterceptor.swift
//  UnSplashSample
//
//  Created by Adrian on 21/4/23.
//

import Alamofire
import Foundation

class HeaderInterceptor: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        adaptedRequest.setValue("v1", forHTTPHeaderField: "Accept-Version")
        adaptedRequest.setValue("Client-ID \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")
        completion(.success(adaptedRequest))
    }
}
