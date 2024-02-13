//
//  BaseError.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation
import Alamofire

class BaseError {
    var errorMessage: String?
    var statusCode: Int?
    var debugMessage: String?
    
    init(_ afError : AFError?) {
        debugMessage = afError.debugDescription
        statusCode = afError?.responseCode
        errorMessage = afError?.errorDescription
    }
}
