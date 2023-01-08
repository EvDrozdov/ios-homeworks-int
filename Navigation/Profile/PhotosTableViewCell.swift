//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Евгений Дроздов on 31.10.2022.
//


import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    static var identifier: String = "photosTableViewCell"
    private let postImage = PostImage.setupImages()
    
    private enum Constants {
        static let numberOfLine: CGFloat = 4
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var nameLb: UILabel = {
       let nameLb = UILabel()
        nameLb.textColor = .black
        nameLb.font = .systemFont(ofSize: 24, weight: .bold)
        nameLb.text = "Photos"
        nameLb.translatesAutoresizingMaskIntoConstraints = false
        return nameLb
    }()
    
    private lazy var rightImage: UIImageView = {
       let rightImage = UIImageView()
        rightImage.image = UIImage(systemName: "arrow.right")
        rightImage.tintColor = .black
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        return rightImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        contentView.addSubview(nameLb)
        contentView.addSubview(rightImage)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            nameLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            nameLb.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),

            rightImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            rightImage.centerYAnchor.constraint(equalTo: nameLb.centerYAnchor),
            rightImage.heightAnchor.constraint(equalToConstant: 24),
            rightImage.widthAnchor.constraint(equalToConstant: 24),

            collectionView.topAnchor.constraint(equalTo: nameLb.bottomAnchor,constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }

}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath)}
        let avaImage = postImage[indexPath.item]
        cell.setup(with: avaImage)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section \(indexPath.section) - item \(indexPath.row)")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        
        let needed = collectionView.frame.width - (Constants.numberOfLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor(needed / Constants.numberOfLine)
        print("itemwidth \(itemwidth)")
        return CGSize(width: itemwidth, height: itemwidth)
    }
}
