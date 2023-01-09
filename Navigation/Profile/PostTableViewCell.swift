//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Евгений Дроздов on 24.10.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    

    private(set) lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        return authorLabel
    }()
    
    private(set) lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private(set) lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    private(set) lazy var likesViewsLabel: UILabel = {
        let likesViewsLabel = UILabel()
        likesViewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
        likesViewsLabel.textColor = .black
        likesViewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesViewsLabel
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
        
    private func setupView() {
        
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(likesViewsLabel)
            
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            postImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            likesViewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            likesViewsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            likesViewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            likesViewsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            ])
    }
    
    
}

