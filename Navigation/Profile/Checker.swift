//
//  Checker.swift
//  Navigation
//
//  Created by Евгений Дроздов on 08.01.2023.
//

import UIKit

import UIKit

 class Checker {
     static var shared = Checker()

     private let loginCheck: String = "Evgeny"
     private let passCheck: String = "Drozdov"
     var user: User?

         func check(login: String, pass: String) -> Bool {
             if (login == loginCheck) && (pass == passCheck) {
                  user = User(login: "Evgeny", fullName: "Hipster Cat", avatarImage: UIImage(named: "cat")! , status: "Waiting for something" )
                 return true
             } else {
                 return false
             }
         }
 }
