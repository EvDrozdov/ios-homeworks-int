//
//  LoginFactore.swift
//  Navigation
//
//  Created by Евгений Дроздов on 08.01.2023.
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
    
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
