//
//  HomePresenter.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import UIKit

typealias HomePresenterDependencies = (
    interactor: HomeInteractor,
    router: HomeRouterOutput
)

class HomePresenter {

    var view: HomeViewInputs?
    internal var entites: HomeEntities
    let dependencies: HomePresenterDependencies
    var countries: [(name: String, alphaCode: String)] = []
    var categories: [(title: String, value: String)] = []
    var selectedCountry: (name: String, alphaCode: String)?
    var selectedCategory: (title: String, value: String)?

    init(view: HomeViewInputs,
        entites: HomeEntities,
        dependencies: HomePresenterDependencies) {
        self.view = view
        self.entites = entites
        self.dependencies = dependencies
    }
}

extension HomePresenter: HomeViewOutputs {
    func viewDidLoad() {
        view?.configure(entities: HomeEntities(entryEntity: HomeEntryEntity()))
        entites.apiState = .loading
        view?.indicatorView(animate: true)
        dependencies.interactor.fetchFeeds(country: "us", category: FeedCategory.music)
        dependencies.interactor.getCountries()
        dependencies.interactor.getCategories()
        view?.setupTableViewCell()
    }

    func onCloseButtonTapped() {
        dependencies.router.dismiss(animated: true)
    }
    
    func fetchFeed() {
        view?.indicatorView(animate: true)
        dependencies.interactor.fetchFeeds(country: selectedCountry?.alphaCode.lowercased() ?? "us", category: FeedCategory(rawValue: selectedCategory?.value ?? "music") ?? FeedCategory.music)
    }
}

extension HomePresenter: HomeTableViewDataSourceOutputs {
    func didSelect(_ feed: Result, order: Int) {
        dependencies.router.navigateToDetail(feed: feed, order: order)
    }
    
    func loadImage(cell: HomeTableViewCell, url: URL?) {
        dependencies.interactor.loadImage(cell: cell, url: url)
    }
}

extension HomePresenter: HomeInteractorOutputs {
    func displayImage(cell: HomeTableViewCell, image: Data?) {
        if let image, let uiImage = UIImage(data: image) {
            cell.displayImage(uiImage)
        }
    }
    
    func onSuccessSearch(res: FeedResponse) {
        entites.apiState = .complete
        entites.feedRepositories = res
        view?.reloadTableView(tableViewDataSource: HomeTableViewDataSource(entities: entites, presenter: self))
        view?.indicatorView(animate: false)
    }

    func onErrorSearch(error: BaseError?) {
        entites.apiState = .complete
        entites.feedRepositories = nil
        view?.reloadTableView(tableViewDataSource: HomeTableViewDataSource(entities: entites, presenter: self))
        view?.indicatorView(animate: false)
    }
    
    func fetchedCountries(countries: [(name: String, alphaCode: String)]) {
        self.countries = countries
    }
    
    func fetchedCategories(categories: [(title: String, value: String)]) {
        self.categories = categories
    }
}
