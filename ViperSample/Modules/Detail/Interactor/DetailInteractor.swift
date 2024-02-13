//
//  DetailInteractor.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 13.02.2024.
//

import Foundation
import Alamofire

protocol DetailInteractorOutputs {
    func displayImage(image: Data?)
}

class DetailInteractor: Interactorable {
    var presenter: DetailInteractorOutputs?
    
    func loadImage(url: URL?) {
        guard let url else { return }
        AF.request(url).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.presenter?.displayImage(image: data)
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
                self?.presenter?.displayImage(image: nil)
            }
        }
    }
}
