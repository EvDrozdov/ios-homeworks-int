//
//  PhotoViewModel.swift
//  Navigation
//
//  Created by Евгений Дроздов on 14.02.2023.
//

import UIKit

final class PhotoViewModel {
    var ImagesArray: [String]

    var ImageNames: [String]? {
        didSet {
            self.imageNameDidChenge?(self)
        }
    }

    init(model: [String]) {
        self.ImagesArray = model
    }

    var imageNameDidChenge: ((PhotoViewModel) -> ())?

    func showMagic() {
        ImageNames = ImagesArray
    }
}
