//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Евгений Дроздов on 11.09.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView{
    
    private lazy var profileHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var catTextLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Hipster Cat"
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
     lazy var catAvatarImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "cat")
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor(ciColor: .white).cgColor
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private lazy var statusLabel: UILabel = {
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something"
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    private lazy var textFild:UITextField = {
        
        let textFild = UITextField()
        textFild.textColor = .black
        textFild.font = .systemFont(ofSize: 15, weight: .regular)
        textFild.backgroundColor = .white
        textFild.layer.cornerRadius = 12
        textFild.layer.borderWidth = 1
        textFild.layer.borderColor = UIColor(ciColor: .black).cgColor
        textFild.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textFild.translatesAutoresizingMaskIntoConstraints = false
        return textFild
    }()
    
    private lazy var button: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 16, y: 206, width: 380, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor(ciColor: .black).cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    override init(reuseIdentifier identifier: String?) {
        super.init(reuseIdentifier: identifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        self.addSubview(self.profileHeaderView)
        
        self.addSubview(self.textFild)
        self.addSubview(self.statusLabel)
        self.addSubview(self.catAvatarImage)
        self.addSubview(self.button)
        self.addSubview(self.catTextLabel)
        
        
        
        NSLayoutConstraint.activate([
            
            profileHeaderView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            catAvatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            catAvatarImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            catAvatarImage.heightAnchor.constraint(equalToConstant: 100),
            catAvatarImage.widthAnchor.constraint(equalToConstant: 100),
            
            catTextLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            catTextLabel.leadingAnchor.constraint(equalTo: self.catAvatarImage.trailingAnchor, constant: 16),
            
            button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: self.catAvatarImage.bottomAnchor, constant: 32),
            button.heightAnchor.constraint(equalToConstant: 50),
           
            textFild.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -20),
            textFild.heightAnchor.constraint(equalToConstant: 40),
            textFild.leadingAnchor.constraint(equalTo: self.catAvatarImage.trailingAnchor, constant: 16),
            textFild.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            statusLabel.bottomAnchor.constraint(equalTo: self.textFild.topAnchor, constant: 16),
            statusLabel.heightAnchor.constraint(equalToConstant: 50),
            statusLabel.leadingAnchor.constraint(equalTo: self.catAvatarImage.trailingAnchor, constant: 16)
            
            
        ])
    }
    
    private var statusText: String = ""
    
    @objc func buttonPressed() {
        
        if let text = statusLabel.text {
            print(text)
        } else {
            print("Пусто")
        }
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textFild: UITextField) {
        
        statusText = textFild.text ?? ""
    }
    
    
}
