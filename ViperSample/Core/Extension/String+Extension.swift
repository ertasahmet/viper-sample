//
//  String+Extension.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation

extension String {
    func getUrl() -> URL? {
        return URL(string: self)
    }
}
