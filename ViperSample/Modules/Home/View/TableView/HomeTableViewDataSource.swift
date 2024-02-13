//
//  HomeTableViewDataSource.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import Foundation
import UIKit

protocol HomeTableViewDataSourceOutputs: AnyObject {
    func didSelect(_ feed: Result, order: Int)
    func loadImage(cell: HomeTableViewCell, url: URL?)
}

protocol TableViewItemDataSource: AnyObject {
    var numberOfItems: Int { get }
    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(tableView: UITableView, indexPath: IndexPath)
}

class HomeTableViewDataSource: TableViewItemDataSource {
    private var entities: HomeEntities!
    private weak var presenter: HomeTableViewDataSourceOutputs?

    init(entities: HomeEntities!, presenter: HomeTableViewDataSourceOutputs) {
        self.entities = entities
        self.presenter = presenter
    }
    var numberOfItems: Int {
        return entities.feedRepositories?.feed?.results?.count ?? 0
    }

    func itemCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else { return UITableViewCell() }
        guard let item = entities.feedRepositories?.feed?.results?[indexPath.row] else { return cell }
        cell.delegate = self
        cell.setupCell(item: item, id: indexPath.row + 1)
        return cell
    }

    func didSelect(tableView: UITableView, indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedItem = entities.feedRepositories?.feed?.results?[indexPath.row] else { return }
        presenter?.didSelect(selectedItem, order: indexPath.row + 1)
    }
}

extension HomeTableViewDataSource: HomeTableViewCellDelegate {
    func loadImage(for cell: HomeTableViewCell, url: URL?) {
        presenter?.loadImage(cell: cell, url: url)
    }
}
