//
//  ShowTableViewCell.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import UIKit
import Kingfisher

class ShowTableViewCell: UITableViewCell {
    
    weak var delegate: DeleteDelgate?
    private let containerView = UIView()
    private let showImageView = UIImageView()
    private let nameLabel = UILabel()
    private let deleteButton = UIButton()
    var id = 0

    
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
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 4
        deleteButton.setTitleColor(.blue, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAnime), for: .touchUpInside)
        containerView.addSubview(deleteButton)
        
    
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
        
        NSLayoutConstraint.activate([
                    deleteButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
                    deleteButton.leadingAnchor.constraint(equalTo: showImageView.leadingAnchor, constant: padding),

                ])
        
    }
    
//    private func getCategoriesText(categories: [String]) -> String {
//        return categories.joined(separator: ", ")
//    }
//
    func configure(for show: Show) {
        let photoURL = URL(string:"https://i.pinimg.com/originals/50/9c/65/509c659e8ec1d7edbac70a7be3bfb966.jpg")
        showImageView.kf.setImage(with: photoURL)
        nameLabel.text = show.name
        self.id = show.id
       
    }
    
    @objc func deleteAnime() {
        print(self.delegate?.delAnime(id: self.id))
        NetworkManager.deleteShow(id: self.id) { _ in
            print("here")
        }
       
        }
    
}
