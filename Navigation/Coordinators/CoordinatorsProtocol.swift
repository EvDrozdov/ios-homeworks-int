//
//  CoordinatorsProtocol.swift
//  Navigation
//
//  Created by Евгений Дроздов on 14.02.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }

    func start()
}

protocol TabbarCoordinatorProtocol: AnyObject {
    var tabbarController: UITabBarController { get set }

    func start()
}
