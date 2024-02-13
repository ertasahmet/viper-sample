//
//  DetailRouter.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 13.02.2024.
//

import Foundation
import UIKit

class DetailRouter {
    var viewController: DetailVC

    init(viewController: DetailVC) {
        self.viewController = viewController
    }
}

struct DetailRouterInput {
    func view(detailEntity: DetailEntites) -> DetailVC {
        let view = DetailVC()
        let interactor = DetailInteractor()
        let dependicies = DetailPresenterDependecies(
            interactor: interactor,
            router: DetailRouterOutput(view)
        )
        let presenter = DetailPresenter(view: view, entities: detailEntity, dependecies: dependicies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable, entryEntity: DetailEntites) {
        let view = self.view(detailEntity: entryEntity)
        from.push(view, animated: true)
    }
    
    
    func present(from: Viewable, entryEntity: DetailEntites) {
        let nav = UINavigationController(rootViewController: view(detailEntity: entryEntity))
         from.present(nav, animated: true)
     }

}


final class DetailRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

}
