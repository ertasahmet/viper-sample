//
//  HomeContractor.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation

protocol HomeInteractorOutputs {
    func onSuccessSearch(res: FeedResponse)
    func onErrorSearch(error: BaseError?)
    func displayImage(cell: HomeTableViewCell, image: Data?)
    func fetchedCountries(countries: [(name: String, alphaCode: String)])
    func fetchedCategories(categories: [(title: String, value: String)])
}

protocol HomeViewInputs {
    func configure(entities: HomeEntities)
    func reloadTableView(tableViewDataSource: HomeTableViewDataSource)
    func setupTableViewCell()
    func indicatorView(animate: Bool)
}

protocol HomeViewOutputs {
    func viewDidLoad()
    func onCloseButtonTapped()
}
