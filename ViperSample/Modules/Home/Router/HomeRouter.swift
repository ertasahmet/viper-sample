//
//  HomeRouter.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import UIKit

class HomeRouter {
    let navigationController: UINavigationController
    var viewController: HomeVC

    init(view: HomeVC) {
        self.viewController = view
        navigationController = UINavigationController(rootViewController: view)
    }
}

struct HomeRouterInput {
    private func view(entryEntity: HomeEntryEntity) -> HomeVC {
        let view = HomeVC()
        let interactor = HomeInteractor(networkManager: NetworkManager(config: NetworkConfig(baseUrl: Constants.BASE_URL)))

        let dependecies = HomePresenterDependencies(
            interactor: interactor,
            router: HomeRouterOutput(view)
        )

        let presenter = HomePresenter(view: view, entites: HomeEntities(entryEntity: entryEntity), dependencies: dependecies)

        view.presenter = presenter
        view.tableViewDataSource = HomeTableViewDataSource(entities: presenter.entites, presenter: presenter)
        interactor.presenter = presenter
        return view
    }

    func open(from: Viewable, entryEntity: HomeEntryEntity) -> HomeVC {
        return self.view(entryEntity: entryEntity)
    }
}

final class HomeRouterOutput: Routerable {

    private(set) weak var view: Viewable!
    init(_ view: Viewable) {
        self.view = view
    }

    func navigateToDetail(feed: Result, order: Int) {
        let detailEntitites = DetailEntites()
        detailEntitites.feedItem = feed
        detailEntitites.order = order
        DetailRouterInput().push(from: view, entryEntity: detailEntitites)
    }
}
