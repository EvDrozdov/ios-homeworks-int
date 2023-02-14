//
//  ProfileCoordinators.swift
//  Navigation
//
//  Created by Евгений Дроздов on 14.02.2023.
//

import UIKit

class ProfileCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LogInViewController()
        loginVC.coordinator = self
        loginVC.tabBarItem.title = "Profile"
        loginVC.tabBarItem.image = UIImage(systemName: "person")
        navigationController.pushViewController(loginVC, animated: false)
    }

    func toProfileViewController(with user: User) {
        let profileVC = ProfileViewController()
        profileVC.currentUser = user
        profileVC.coordinator = self
        navigationController.pushViewController(profileVC, animated: true)
    }

    func toPhotosViewController() {
        let photosVC = PhotosViewController()
        navigationController.pushViewController(photosVC, animated: true)
    }
}
