//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 31.10.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    var arrayOfImages = [UIImage]()
    var arrayOfFineshedImages = [UIImage]()
    
    var textTitle: String?
    
    //private var postImage = PostImage.setupImages()
    
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
    
    private var dataSource: [String] = []
    private func createData() {
        
        for num in 1...20 {
            dataSource.append("\(num).jpg")
        }
        
        for image in dataSource {
            arrayOfImages.append((UIImage(named: image) ?? UIImage(named:"1.jpg"))!)
        }
        
        let start = DispatchTime.now()
        ImageProcessor().processImagesOnThread(sourceImages: arrayOfImages, filter: .noir, qos: .background) {
            [weak self] chekedImages in DispatchQueue.main.async {
                self?.arrayOfFineshedImages = chekedImages.compactMap {image in
                    if let image = image{
                        return UIImage(cgImage: image)
                    } else {
                        return nil
                    }
                }
                let end = DispatchTime.now()
                
                let time = end.uptimeNanoseconds - start.uptimeNanoseconds
                self?.collectionView.reloadData()
                
                let timeInterval = Double(time) / 1_000_000_000
                print("Время обработки: \(timeInterval)")
                
                // Результат : userInteractive + tonal Время обработки: 9.234091895
                // Рещультат : background + fade Время обработки: 8.80964687
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createData()
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
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell {
            let image = arrayOfFineshedImages[indexPath.row]
            cell.setup(for: image)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
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
