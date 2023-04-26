//
//  ApiManager.swift
//  UnSplashSample
//
//  Created by Adrian on 19/4/23.
//

import Foundation
import Alamofire

class ApiManager: Api {

    private let baseURL: String

    private let requestInterceptor: RequestInterceptor

    init(baseURL: String, requestInterceptor: RequestInterceptor) {
        self.baseURL = baseURL
        self.requestInterceptor = requestInterceptor
    }

    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            Task {
                do {
                    let result = try await makeRequest(endpoint, responseType: responseType)
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    private func makeRequest<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let url = baseURL + endpoint.path
            let method = endpoint.method
            let parameters = endpoint.parameters
            let encoding: ParameterEncoding = endpoint.encoding ?? JSONEncoding.default
            let postParameters = endpoint.method == .post ? parameters : nil
            var requestUrl = URL(string: url)!
            if method == .get, let queryParams = parameters {
                if let urlWithParams = addQueryParameters(queryParams, to: requestUrl) {
                    requestUrl = URL(string: urlWithParams)!
                }
            }
            AF.request(requestUrl,
                       method: method,
                       parameters: postParameters,
                       encoding: encoding,
                       interceptor: requestInterceptor
            )
            .validate(contentType: ["application/json"])
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    private func addQueryParameters(_ parameters: [String: Any], to url: URL) -> String? {
          var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
          components.queryItems = parameters.map { key, value in
              URLQueryItem(name: key, value: "\(value)")
          }
          return components.url?.absoluteString
      }
}
