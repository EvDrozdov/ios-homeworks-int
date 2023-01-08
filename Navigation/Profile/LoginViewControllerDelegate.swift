//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Евгений Дроздов on 08.01.2023.
//

import UIKit


protocol LoginViewControllerDelegate {
     func check(login: String, pass: String) -> Bool
 }
