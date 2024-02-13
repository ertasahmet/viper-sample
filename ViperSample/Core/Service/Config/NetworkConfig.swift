//
//  NetworkConfig.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation

class NetworkConfig {
    var baseUrl: String
    var headers: [String: String]?

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}
