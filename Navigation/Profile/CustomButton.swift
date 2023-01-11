//
//  CustomButton.swift
//  Navigation
//
//  Created by Евгений Дроздов on 11.01.2023.
//

import UIKit

class CustomButton: UIButton {
    private let tapClosure: (() ->())
    
    init(customTitle: String, closure: @escaping (() -> ())) {
        
        self.tapClosure = closure
        super.init(frame: .zero)
        
        setTitle(customTitle, for: .normal)
        tintColor = .white
        backgroundColor = .systemYellow
        translatesAutoresizingMaskIntoConstraints = false
        
        
        addTarget(self, action: #selector(tap), for: .touchUpInside)
        
    }
    
    @objc private func tap() {
        tapClosure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
