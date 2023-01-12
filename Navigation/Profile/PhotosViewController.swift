//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 31.10.2022.
//

import UIKit

import iOSIntPackage




class PhotosViewController: UIViewController {

    var textTitle: String?
    
    private let postImage = PostImage.setupImages()
    
    private var recivedImages: [UIImage] = []
    private let imagesFacade = ImagePublisherFacade()
    
    private enum Constants {
        static let numberOfLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        makeData()
        setupObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imagesFacade.removeSubscription(for: self)
    }
    
    private var data : [String] = []
    private func makeData() {
        for num in 1...20 {
            data.append("\(num).jpg")
        }
    }
    
    private func setupObserver() {
        var array2: [UIImage] = []
        imagesFacade.subscribe(self)
        data.forEach { i in array2.append(UIImage(named: i)!)
            
        }
        imagesFacade.addImagesWithTimer(time: 2, repeat: 20, userImages: array2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = textTitle
        print("viewWillAppear")
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("viewWillDisappear")
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupCollectionView() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recivedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath)}
        let avaImage = postImage[indexPath.row]
        cell.setup(with: avaImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section - \(indexPath.section) - Item \(indexPath.item)")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let needed = collectionView.frame.width - (Constants.numberOfLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor(needed / Constants.numberOfLine)
        print(itemwidth)
        return CGSize(width: itemwidth, height: itemwidth)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        recivedImages = images
        collectionView.reloadData()
    }
}
