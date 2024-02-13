//
//  BaseResponse.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation

struct BaseResponse<T : Codable> {
    var result: T?
}
