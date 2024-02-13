//
//  DetailVC.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 13.02.2024.
//

import UIKit
import SnapKit

protocol DetailViewInputs {
    func configure(entities: DetailEntites)
    func displayImage(image: UIImage)
}

protocol DetailViewOutputs {
    func viewDidLoad()
    func onBackButton()
    func loadImage(url: URL?)
}

class DetailVC: UIViewController {
    let appLogoImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.image = UIImage(named: "noval_logo")
       imageView.contentMode = .scaleAspectFit
       return imageView
    }()

    let backButton: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(named: "back_icon"), for: .normal)
       button.setTitleColor(.white, for: .normal)
       return button
    }()

    let imageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.clipsToBounds = true
       return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let descLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "SongGrayColor")
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let propertiesContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BorderGrayColor")
        return view
    }()

    let releaseDateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BorderGrayColor")
        return view
    }()
    
    let releaseDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "Inter-Bold", size: 16)
        label.backgroundColor = UIColor(named: "BgBlackColor")
        label.textAlignment = .center
        return label
    }()

    let releaseDateValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "SongGrayColor")
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.backgroundColor = UIColor(named: "BgBlackColor")
        label.textAlignment = .center
        return label
    }()

    let orderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BorderGrayColor")
        return view
    }()
    
    let orderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "Inter-Bold", size: 16)
        label.backgroundColor = UIColor(named: "BgBlackColor")
        label.textAlignment = .center
        return label
    }()

    let orderValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "SongGrayColor")
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.backgroundColor = UIColor(named: "BgBlackColor")
        label.textAlignment = .center
        return label
    }()

    internal var presenter: DetailViewOutputs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "BgBlackColor")
        view.addSubview(appLogoImageView)
        view.addSubview(backButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(propertiesContainerView)
        propertiesContainerView.addSubview(releaseDateView)
        propertiesContainerView.addSubview(orderView)
        releaseDateView.addSubview(releaseDateTitleLabel)
        releaseDateView.addSubview(releaseDateValueLabel)
        orderView.addSubview(orderTitleLabel)
        orderView.addSubview(orderValueLabel)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        appLogoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.height.equalTo(80)
        }

        backButton.snp.makeConstraints { make in
           make.leading.equalToSuperview().offset(20)
           make.centerY.equalTo(appLogoImageView)
            make.width.height.equalTo(25)
        }

        imageView.snp.makeConstraints { make in
           make.centerX.equalToSuperview()
           make.top.equalTo(appLogoImageView.snp.bottom).offset(20)
           make.width.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        propertiesContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(50)
            make.height.equalTo(120)
        }
        
        releaseDateView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
            make.top.equalTo(propertiesContainerView.snp.top).offset(1)
        }
        
        releaseDateTitleLabel.snp.makeConstraints { make in
            make.leading.top.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.498)
        }
        
        releaseDateValueLabel.snp.makeConstraints { make in
            make.trailing.top.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        orderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(releaseDateView.snp.bottom).offset(1)
            make.bottom.equalToSuperview().offset(-1)
        }
        
        orderTitleLabel.snp.makeConstraints { make in
            make.leading.top.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.498)
        }
        
        orderValueLabel.snp.makeConstraints { make in
            make.trailing.top.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .white
        separator.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        return separator
    }
    
    @objc func backButtonTapped() {
        presenter?.onBackButton()
    }

}

extension DetailVC: Viewable { }

extension DetailVC: DetailViewInputs {
    func configure(entities: DetailEntites) {
        guard let item = entities.feedItem else { return }
        titleLabel.text = item.name
        descLabel.text = item.artistName
        releaseDateTitleLabel.text = "Release Date"
        releaseDateValueLabel.text = item.releaseDate ?? ""
        orderTitleLabel.text = "Order"
        orderValueLabel.text = "#\(entities.order ?? 0)"
        presenter?.loadImage(url: URL(string: item.artworkUrl100 ?? ""))
    }
    
    func displayImage(image: UIImage) {
        imageView.image = image
    }

}
