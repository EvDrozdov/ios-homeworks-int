//
//  PostViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//

import UIKit


class PostViewController: UIViewController {
    
    var post: NewTitle?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .systemMint
        title = post?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAddModal))
    }
    
    @objc private func tapAddModal() {
        present(InfoViewController(), animated: true, completion: nil)
    }
}

