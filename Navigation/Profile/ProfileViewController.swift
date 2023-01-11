//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//


import UIKit


class ProfileViewController: UIViewController{
    
    var startPoint: CGPoint?
    var cornerRadiusAvatar: CGFloat?
    var newUser: User? = nil
    
    public lazy var catImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "cat")
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.alpha = 0
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()
    
    private lazy var clouseButton: UIImageView = {
        let cancelButton = UIImageView()
        cancelButton.image = UIImage(systemName: "multiply.circle.fill")
        cancelButton.isUserInteractionEnabled = true
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    private lazy var screenView: UIView = {
        let fullscreenBackView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        fullscreenBackView.alpha = 0
        fullscreenBackView.backgroundColor = .black
        fullscreenBackView.isUserInteractionEnabled = true
        fullscreenBackView.translatesAutoresizingMaskIntoConstraints = false
        return fullscreenBackView
    }()
    
    
    private var movies: [Post] = MassiveOfPosts.viewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultcell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupView()
        setupGestures()
    }
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        startPoint = self.catImageView.center
        cornerRadiusAvatar = catImageView.frame.width / 2
        catImageView.layer.cornerRadius = cornerRadiusAvatar!
    }
    
    private func setupView() {
        
#if DEBUG
        view.backgroundColor = .green
#else
        view.backgroundColor = .white
#endif
        
        
        view.addSubview(tableView)
        view.addSubview(screenView)
        view.addSubview(catImageView)
        screenView.addSubview(clouseButton)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            catImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            catImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            catImageView.widthAnchor.constraint(equalToConstant: 100),
            catImageView.heightAnchor.constraint(equalToConstant: 100),
            
            screenView.topAnchor.constraint(equalTo: view.topAnchor),
            screenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            clouseButton.topAnchor.constraint(equalTo: screenView.topAnchor, constant: view.bounds.width * 0.1),
            clouseButton.trailingAnchor.constraint(equalTo: screenView.trailingAnchor, constant: -1 * view.bounds.width * 0.05),
            
            clouseButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            clouseButton.heightAnchor.constraint(equalTo: clouseButton.widthAnchor),
            
        ])
    }
    private func setupGestures() {
        let tapOnfullscreenBackView = UITapGestureRecognizer(target: self, action: #selector(tapOnFullScreen))
        screenView.addGestureRecognizer(tapOnfullscreenBackView)
        
        let tapCancel = UITapGestureRecognizer(target: self, action: #selector(tapCancelButton))
        clouseButton.addGestureRecognizer(tapCancel)
    }
    @objc func tapOnAvatarImage() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .allowUserInteraction) {
            self.catImageView.alpha = 1
            self.screenView.alpha = 0.5
            self.catImageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.catImageView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.catImageView.layer.cornerRadius = 0
            }
        }
    }
    
    @objc func tapOnFullScreen() {
    }
    
    @objc func tapCancelButton() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut) {
            self.catImageView.transform = .identity
            self.catImageView.center = self.startPoint ?? CGPoint(x: 0, y: 0)
            self.catImageView.layer.cornerRadius = self.cornerRadiusAvatar ?? 2
            self.catImageView.alpha = 0
        } completion: { _ in
            self.screenView.alpha = 0
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellOne = tableView.dequeueReusableCell(withIdentifier: "PhotosTableCell") as? PhotosTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath) }
        guard let cellTwo = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { return tableView.dequeueReusableCell(withIdentifier: "defaultcell", for: indexPath) }
        cellTwo.authorLabel.text = movies[indexPath.row].author
        cellTwo.postImageView.image = UIImage(named: movies[indexPath.row].image)
        cellTwo.descriptionLabel.text = movies[indexPath.row].description
        cellTwo.likesViewsLabel.text = "views: \(movies[indexPath.row].views) likes: \(movies[indexPath.row].likes)"
        return indexPath.section == 0 ? cellOne : cellTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Section \(indexPath.section) - Row \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated:true)
        let vc = PhotosViewController()
        vc.textTitle = "Photo Gallery"
        indexPath.section == 0 ? navigationController?.pushViewController(vc, animated: true) : nil
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView")as? ProfileHeaderView else { return nil }
            if let newUser = newUser {
                header.setup(fullName: newUser.fullName, avatarimage: newUser.avatarImage, status: newUser.status)}
            
            
            let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
            header.catAvatarImage.addGestureRecognizer(tapOnAvatarImageGusture)
            header.catAvatarImage.isUserInteractionEnabled = true
            return header
        } else {
            return nil
        }
    }
}
