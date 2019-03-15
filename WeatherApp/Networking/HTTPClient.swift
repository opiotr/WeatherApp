//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Piotr Olech on 15/03/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Alamofire

final class HTTPClient {
    
    // MARK: - Singleton
    
    static let shared = HTTPClient()
    
    // MARK: - Private properties
    
    private let sessionManager: SessionManager
    
    // MARK: - Initialization
    
    private init(sessionManager: SessionManager = .default) {
        self.sessionManager = sessionManager
    }
    
    // MARK: - Access methods
    
    func request<Response: Codable>(_ endpoint: Endpoint<Response>, success: @escaping (Response) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = createAbsoluteUrl(with: endpoint.path) else {
            failure(NSError(domain: "Preparing request url error", code: -1, userInfo: nil))
            return
        }
        let request = sessionManager.request(url,
                                             method: endpoint.method,
                                             parameters: endpoint.parameters,
                                             encoding: endpoint.encoding,
                                             headers: endpoint.headers)
        request
            .validate()
            .responseData { response in
                let result = response.result.flatMap(endpoint.decode)
                switch result {
                case let .success(data):
                    success(data)
                case let .failure(error):
                    failure(error)
                }
        }
    }
    
    // MARK: - Preparing request url
    
    private func createAbsoluteUrl(with path: String) -> URL? {
        var url = URL(string: Config.baseApiUrl)
        url?.appendPathComponent(path)
        return url
    }
}
