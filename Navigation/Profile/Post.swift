//
//  Post.swift
//  Navigation
//
//  Created by Евгений Дроздов on 17.10.2022.
//

import UIKit



struct Post {
    
    var author: String
    var image: String
    var description: String
    var likes: Int
    var views: Int
    
}

struct MassiveOfPosts {
    
    static let viewModel: [Post] = [

        Post(author: "Цельнометаллическая оболочка", image: "Post1", description: "Военная драма", likes: 203, views: 144),
        Post(author: "Кольца силы", image: "Post2", description: "Фентези", likes: 121, views: 188),
        Post(author: "Ведьмак", image: "Post3", description: "Сериал про Геральта из Ривии", likes: 17, views: 138),
        Post(author: "Робокоп", image: "Post4", description: "Фильм про киборга", likes: 186, views: 291)]
    
}





struct PostImage {
    var image: String
    
    static func setupImages() -> [PostImage]{
        let data = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg","12.jpg","13.jpg","14.jpg","15.jpg","16.jpg","17.jpg","18.jpg","19.jpg","20.jpg",]

        var tempImage = [PostImage]()
        for (_, names) in data.enumerated() {
            tempImage.append(PostImage(image: names))
        }
        return tempImage
    }
}



