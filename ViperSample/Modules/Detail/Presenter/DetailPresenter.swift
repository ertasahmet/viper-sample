//
//  DetailPresenter.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 13.02.2024.
//

import UIKit

typealias DetailPresenterDependecies = (
    interactor: DetailInteractor,
    router: DetailRouterOutput
)

class DetailPresenter {

    var view: DetailViewInputs?
    internal var entities: DetailEntites
    let dependecies: DetailPresenterDependecies

    init(view: DetailViewInputs, entities: DetailEntites, dependecies: DetailPresenterDependecies) {
        self.view = view
        self.entities = entities
        self.dependecies = dependecies
    }
}

extension DetailPresenter: DetailInteractorOutputs {
    func displayImage(image: Data?) {
        if let image, let uiImage = UIImage(data: image) {
            view?.displayImage(image: uiImage)
        }
    }
}

extension DetailPresenter: DetailViewOutputs {
    func viewDidLoad() {
        view?.configure(entities: entities)
    }

    func onBackButton() {
        dependecies.router.pop(animated: true)
    }
    
    func loadImage(url: URL?) {
        dependecies.interactor.loadImage(url: url)
    }
}
