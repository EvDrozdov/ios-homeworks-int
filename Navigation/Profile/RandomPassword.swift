//
//  RandomPassword.swift
//  Navigation
//
//  Created by Евгений Дроздов on 02.04.2023.
//

import UIKit

extension String {
    static func createRandomPassword(for symbols: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomCharacters = (0...symbols-1).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        print("I made password - ", randomString)
        return randomString
    }
}
