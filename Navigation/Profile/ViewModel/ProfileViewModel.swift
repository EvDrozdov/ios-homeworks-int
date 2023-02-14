//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Евгений Дроздов on 14.02.2023.
//

import UIKit

class ProfileViewModel {
    var movies: [Post]?
    var oneMoreTmpUser: User?
    
    var user: User? {
        didSet {
            self.userDidChange?(self)
        }
    }
    
    var userDidChange: ((ProfileViewModel) -> ())?
    
    init(userfromLogin: User, cartoons: [Post]) {
        self.oneMoreTmpUser = userfromLogin
    }
    
    func getData() {
        user = oneMoreTmpUser
    }
}
