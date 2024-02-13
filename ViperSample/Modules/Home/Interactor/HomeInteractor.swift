//
//  HomeInteractor.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation
import Alamofire

class HomeInteractor: Interactorable {
    var presenter: HomeInteractorOutputs?
    var networkManager: INetworkService

    init(networkManager: INetworkService) {
        self.networkManager = networkManager
    }

    func fetchFeeds(country: String, category: FeedCategory) {
        networkManager.get(path: getPathForCategory(category: category), ["country": country], onSuccess: { [weak self] (response: BaseResponse<FeedResponse>) in
            guard let data = response.result else {
                self?.presenter?.onErrorSearch(error: nil)
                return
            }
            self?.presenter?.onSuccessSearch(res: data)
        }) { [weak self] (error) in
            self?.presenter?.onErrorSearch(error: error)
        }
    }
    
    private func getPathForCategory(category: FeedCategory) -> NetworkPath {
        switch category {
        case .music:
            return NetworkPath.music
        case .podcasts:
            return NetworkPath.podcast
        case .apps:
            return NetworkPath.apps
        case .books:
            return NetworkPath.books
        case .audioBooks:
            return NetworkPath.audiobooks
        }
    }
    
    func getCountries() {
        var countries: [(name: String, alphaCode: String)] = []
        let identifiers = Locale.isoRegionCodes
        for identifier in identifiers {
            let locale = Locale(identifier: "en_US")
            let countryName = locale.localizedString(forRegionCode: identifier) ?? "Unknown"
            let countryTuple = (name: countryName, alphaCode: identifier)
            countries.append(countryTuple)
        }
        presenter?.fetchedCountries(countries: countries)
    }
    
    func getCategories() {
        var categories: [(title: String, value: String)] = [(title: "Music", value: FeedCategory.music.rawValue), (title: "Podcasts", value: FeedCategory.podcasts.rawValue), (title: "Apps", value: FeedCategory.apps.rawValue), (title: "Books", value: FeedCategory.books.rawValue), (title: "Audio Books", value: FeedCategory.audioBooks.rawValue)]
        presenter?.fetchedCategories(categories: categories)
    }
    
    func loadImage(cell: HomeTableViewCell, url: URL?) {
        guard let url else { return }
        AF.request(url).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.presenter?.displayImage(cell: cell, image: data)
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
                self?.presenter?.displayImage(cell: cell, image: nil)
            }
        }
    }
}
