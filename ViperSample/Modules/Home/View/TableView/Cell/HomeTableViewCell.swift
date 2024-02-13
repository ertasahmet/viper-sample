//
//  HomeTableViewCell.swift
//  ViperSample
//
//  Created by Ahmet Ertas on 12.02.2024.
//

import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func loadImage(for cell: HomeTableViewCell, url: URL?)
}

class HomeTableViewCell: UITableViewCell {

    weak var delegate: HomeTableViewCellDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SongGrayColor")
        label.font = UIFont(name: "Inter-Medium", size: 16)
        return label
    }()

    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Inter-Bold", size: 20)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "SongGrayColor")
        label.font = UIFont(name: "Inter-Medium", size: 11)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let separatorView: UIView = {
      let view = UIView()
        view.backgroundColor = UIColor(named: "BorderGrayColor")
      return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "BgBlackColor")
    
        contentView.addSubview(containerView)
        containerView.addSubview(numberLabel)
        containerView.addSubview(albumImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        containerView.addSubview(separatorView)
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(100)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.greaterThanOrEqualTo(20)
            make.centerY.equalToSuperview()
        }
       
        albumImageView.snp.makeConstraints { make in
            make.leading.equalTo(numberLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(albumImageView.snp.top).offset(10)
        }
      
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
       
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.greaterThanOrEqualTo(descLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
    }
    
    func setupCell(item: Result, id: Int) {
        numberLabel.text = String(id)
        titleLabel.text = item.name
        descLabel.text = item.artistName
        delegate?.loadImage(for: self, url: URL(string: item.artworkUrl100 ?? ""))
    }
    
    func displayImage(_ image: UIImage) {
        albumImageView.image = image
    }
}
