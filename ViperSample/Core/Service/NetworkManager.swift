//
//  NetworkManager.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation
import Alamofire

typealias Success<T : Codable> = (BaseResponse<T>) -> Void
typealias Error = (BaseError) -> Void

class NetworkManager: INetworkService {
    private var baseUrl: String

    init(config: NetworkConfig) {
        self.baseUrl = config.baseUrl
    }

    func get<T: Codable>(
        path: NetworkPath,
        _ paramaters: [String: String]?,
        onSuccess: @escaping Success<T>,
        onError: @escaping Error
    ) {
        AF.request(networkRequestUrl(path, paramaters?["country"] ?? "us"),
            method: .get,
            parameters: paramaters
        ).validate().responseDecodable(of: T.self)
        { (response) in
            guard let result = response.value else {
                onError(BaseError(response.error))
                return
            }
            onSuccess(BaseResponse.init(result: result))
        }
    }

}

extension NetworkManager {
    func networkRequestUrl(_ path: NetworkPath, _ country: String) -> String {
        return baseUrl.replacingOccurrences(of: "@country", with: country) + "/" + path.rawValue
    }
}
