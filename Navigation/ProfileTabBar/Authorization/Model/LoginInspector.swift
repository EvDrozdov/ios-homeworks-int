//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгений Дроздов on 08.01.2023.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate{
     func check(login: String, pass: String) -> Bool {
        return Checker.shared.check(login: login, pass: pass)
     }
 }
