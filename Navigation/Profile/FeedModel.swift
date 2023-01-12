//
//  FeedModel.swift
//  Navigation
//
//  Created by Евгений Дроздов on 11.01.2023.
//

import Foundation

class FeedModel {
    private let secretWord = "Apple"
    
    func check(word: String) -> Bool {
        
        word == secretWord
    }
}
