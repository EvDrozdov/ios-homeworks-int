//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Евгений Дроздов on 14.02.2023.
//

import UIKit

class FeedCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "square.grid.3x3.topright.fill")
        navigationController.pushViewController(feedVC, animated: false)
    }

    func toPostViewController(send post: NewTitle) {
        let postVC = PostViewController()
        postVC.post = post
        navigationController.pushViewController(postVC, animated: true)
    }
}
