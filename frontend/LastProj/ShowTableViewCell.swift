//
//  ShowTableViewCell.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import UIKit
import Kingfisher

class ShowTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let showImageView = UIImageView()
    private let nameLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        
        containerView.layer.cornerRadius = 20
        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        showImageView.translatesAutoresizingMaskIntoConstraints = false
        showImageView.clipsToBounds = true
        showImageView.layer.masksToBounds = true
        showImageView.contentMode = .scaleAspectFill
        containerView.addSubview(showImageView)
        
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 18)
        containerView.addSubview(nameLabel)
        
    
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        let containerPadding: CGFloat = 20
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: containerPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -containerPadding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerPadding)
        ])
        
        NSLayoutConstraint.activate([
            showImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            showImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            showImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            showImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: showImageView.leadingAnchor, constant: padding),

        ])
        
      
        
    }
    
    private func getCategoriesText(categories: [String]) -> String {
        return categories.joined(separator: ", ")
    }
    
    func configure(for show: Show) {
        let photoURL = URL(string:"https://i2.wp.com/www.tor.com/wp-content/uploads/2015/12/NanaTai.png?type=vertical")
        showImageView.kf.setImage(with: photoURL)
        nameLabel.text = show.name
       
    }
    
}
