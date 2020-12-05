//
//  ShowViewController.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import UIKit
import Kingfisher

class ShowViewController: UIViewController {
    
    private var show: Show!
    private let showImageView = UIImageView()
    private let nameLabel = UILabel()
    private let summaryText = UITextView()
    private let reviewTitleLabel = UILabel()
    private let reviewLabel = UILabel()
    private let reviewContainerView = UIView()
    private let seeAllReviewsButton = UIButton()
    
    init(show: Show) {
        super.init(nibName: nil, bundle: nil)
        self.show = show
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        let photoURL = URL(string: show.photo ?? "")
        showImageView.kf.setImage(with: photoURL)
        showImageView.translatesAutoresizingMaskIntoConstraints = false
        showImageView.contentMode = .scaleAspectFill
        showImageView.layer.masksToBounds = true
        view.addSubview(showImageView)
        
        nameLabel.text = show.title
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.font = .boldSystemFont(ofSize: 36)
        view.addSubview(nameLabel)
        
        summaryText.text = show.summary
        summaryText.font = .boldSystemFont(ofSize: 18)
        summaryText.textColor = .black
        summaryText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryText)
        
     


        
       // getRestaurant()
        setupConstraints()
        
    }
    
    
    private func setupConstraints() {
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            showImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            showImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            showImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            summaryText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            summaryText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            summaryText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
      
        
        
    }
    
  
//    private func getShow() {
//        NetworkManager.getShows(id: show.id) { show in
//            self.show = show
//            if let reviews = show.reviews {
//                self.reviewLabel.text = reviews[0]
//                self.reviewContainerView.sizeToFit()
//            }
        }
//    }
//
//}