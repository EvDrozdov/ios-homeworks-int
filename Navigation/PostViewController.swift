//
//  PostViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//

import UIKit


class PostViewController: UIViewController {
    
    let feedViewController = FeedViewController()
        
        @objc func sendToInfoViewController(sender: UIButton) {
            let viewControllerc = InfoViewController()
            navigationController?.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(viewControllerc, animated: true)
        }
    
        override func viewDidLoad() {
              super.viewDidLoad()
            view.backgroundColor = .systemIndigo
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Файлы", style: .done, target: self, action: #selector(sendToInfoViewController(sender:)))
        }

}
