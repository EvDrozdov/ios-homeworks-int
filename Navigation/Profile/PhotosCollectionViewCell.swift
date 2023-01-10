//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Евгений Дроздов on 31.10.2022.
//

import UIKit



class PhotosCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "photosTableViewCell"
    
     lazy var avaImage: UIImageView = {
       let avaImage = UIImageView()
        avaImage.contentMode = .scaleAspectFill
        avaImage.clipsToBounds = true
        avaImage.layer.cornerRadius = 6
        avaImage.translatesAutoresizingMaskIntoConstraints = false
        return avaImage     
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(avaImage)
        NSLayoutConstraint.activate([
            avaImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            avaImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avaImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avaImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    func setup(with post: PostImage) {
        avaImage.image = UIImage(named:post.image)
    }
    
}
