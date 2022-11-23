//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post1 =  "Новости"
    private lazy var postButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.backgroundColor = .systemRed
        button.setTitle("Лента новостей", for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        
        self.view.addSubview(self.postButton)
        self.postButton.center = self.view.center
    }
    
    @objc private func didTapButton() {
        let didTapButton = PostViewController()
        self.navigationController?.pushViewController(didTapButton, animated: true)
    }
    
}
