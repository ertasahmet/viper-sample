//
//  HomeEntities.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation

struct HomeEntryEntity {
   
}

class HomeEntities {

    let entryEntity: HomeEntryEntity
    var feedRepositories: FeedResponse?

    enum ApiState {
        case loading
        case complete
    }

    var apiState = ApiState.complete

    init(entryEntity: HomeEntryEntity) {
        self.entryEntity = entryEntity
    }
}

enum FeedCategory: String {
    case music = "music"
    case podcasts = "podcasts"
    case apps = "apps"
    case books = "books"
    case audioBooks = "audio-books"
}
