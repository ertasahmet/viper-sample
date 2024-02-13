//
//  HomeVC.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noval_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let refreshImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "refresh_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let optionsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BorderGrayColor")
        return view
    }()
    
    private lazy var firstOptionView: UIView = createOptionView(index: 1)
    private lazy var secondOptionView: UIView = createOptionView(index: 2)

    private lazy var countryPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        picker.isHidden = true
        return picker
    }()
    
    private lazy var categoryPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        picker.isHidden = true
        return picker
    }()
    
    private lazy var pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isHidden = true
        return toolbar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    private lazy var customRefreshView: UIView = createCustomRefreshView()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
        
    var refreshControl: UIRefreshControl!

    var presenter: HomePresenter?
    internal var tableViewDataSource: TableViewItemDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "BgBlackColor")
        tableView.backgroundColor = UIColor(named: "BgBlackColor")
        
        view.addSubview(logoImageView)
        optionsContainerView.addSubview(firstOptionView)
        optionsContainerView.addSubview(secondOptionView)
        view.addSubview(optionsContainerView)
        view.addSubview(tableView)
        view.addSubview(countryPickerView)
        view.addSubview(categoryPickerView)
        view.addSubview(pickerToolbar)
        view.addSubview(activityIndicator)
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        refreshControl.addSubview(customRefreshView)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerToolbar.setItems([spaceButton, doneButton], animated: false)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.height.equalTo(80)
        }
        
        optionsContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        
        firstOptionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(58)
            make.top.equalToSuperview().offset(1)
            make.width.equalToSuperview().multipliedBy(0.498)
        }
        
        secondOptionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(1)
            make.height.equalTo(58)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        tableView.snp.makeConstraints { make in
           make.leading.trailing.bottom.equalToSuperview()
           make.top.equalTo(optionsContainerView.snp.bottom).offset(20)
        }
        
        countryPickerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        categoryPickerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        pickerToolbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(countryPickerView.snp.top)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func pullToRefresh() {
        presenter?.fetchFeed()
    }
    
    func createCustomRefreshView() -> UIView {
        let customView = UIView()
        customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        customView.backgroundColor = UIColor(named: "BgBlackColor")
        customView.addSubview(refreshImageView)

        let label = UILabel()
        label.text = "Pull to refresh"
        label.textColor = .white
        label.textAlignment = .center
        customView.addSubview(label)

        refreshImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(20)
        }

        label.snp.makeConstraints { make in
            make.top.equalTo(refreshImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(4)
        }

        return customView
    }
    
    private func createOptionView(index: Int) -> UIView {
        let optionView = UIView()
        optionView.tag = index
        optionView.isUserInteractionEnabled = true
        optionView.backgroundColor = UIColor(named: "BgBlackColor")

        let label = UILabel()
        label.text = index == 1 ? "Country" : "Category"
        label.textColor = UIColor(named: "GhostWhiteColor")
        label.font = UIFont(name: "Inter-Bold", size: 16)
        label.isUserInteractionEnabled = true

        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "arrow_icon")
        arrowImageView.contentMode = .scaleAspectFit

        let button = UIButton()
        button.setTitle("", for: .normal)
        
        optionView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }

        optionView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        
        button.tag = index
        button.addTarget(self, action: #selector(showPickerView(_:)), for: .touchUpInside)
        optionView.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        return optionView
    }
    
    @objc func showPickerView(_ sender: UIButton) {
        if sender.tag == 1 {
            countryPickerView.isHidden = false
        } else {
            categoryPickerView.isHidden = false
        }
        pickerToolbar.isHidden = false
    }

    @objc private func handlePickerDone() {
        countryPickerView.isHidden = true
        categoryPickerView.isHidden = true
        pickerToolbar.isHidden = true
        presenter?.fetchFeed()
    }
    
    @objc func doneButtonTapped() {
        handlePickerDone()
    }
}

extension HomeVC: Viewable { }

extension HomeVC: HomeViewInputs {
    
    func setupTableViewCell() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
    }

    func configure(entities: HomeEntities) {
    }

    func reloadTableView(tableViewDataSource: HomeTableViewDataSource) {
        self.tableViewDataSource = tableViewDataSource
        refreshControl.endRefreshing()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func indicatorView(animate: Bool) {
        DispatchQueue.main.async {
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: animate ? 50 : 0, right: 0)
            _ = animate ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = !animate

        }
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource?.numberOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewDataSource?.itemCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDataSource?.didSelect(tableView: tableView, indexPath: indexPath)
    }

   /* func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleLastIndexPath = homeTableViewController.visibleCells.compactMap { [weak self] in
            self?.homeTableViewController.indexPath(for: $0)
        }.last
        guard let last = visibleLastIndexPath, last.row > (tableViewDataSource?.numberOfItems ?? 0) - 2 else { return }
        presenter?.onReachBottom()
    }*/
}

extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPickerView {
            return presenter?.countries.count ?? 0
        } else {
            return presenter?.categories.count ?? 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPickerView {
            return presenter?.countries[row].name
        } else {
            return presenter?.categories[row].title
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPickerView {
            presenter?.selectedCountry = presenter?.countries[row]
        } else {
            presenter?.selectedCategory = presenter?.categories[row]
        }
    }
}
