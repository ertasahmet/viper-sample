//
//  INetworkManager.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation

protocol INetworkService {
    func get<T : Codable>(path: NetworkPath, _ paramaters: [String: String]?, onSuccess: @escaping (BaseResponse<T>) -> Void, onError: @escaping (BaseError) -> Void)
}
