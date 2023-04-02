//
//  CustomButton.swift
//  Navigation
//
//  Created by Евгений Дроздов on 11.01.2023.
//

import UIKit

class CustomButton: UIButton {
    
    var title: String
    var titleColor: UIColor
    var backgroundButtonColor: UIColor
    var clipsToBoundsOfButton: Bool
    var cornerRadius: CGFloat
    var borderWidth: CGFloat
    var alphaButton: CGFloat
    var borderColor: CGColor
    var autoLayout: Bool
    
    var addTargetForButton = {}
    
    init(title: String, titleColor: UIColor, backgroundButtonColor: UIColor, clipsToBoundsOfButton: Bool, cornerRadius: CGFloat, borderWidth: CGFloat? = nil, alphaButton: CGFloat? = nil, borderColor: CGColor? = nil, autoLayout: Bool) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundButtonColor = backgroundButtonColor
        self.clipsToBoundsOfButton = clipsToBoundsOfButton
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth ?? 0
        self.alphaButton = alphaButton ?? 1
        self.borderColor = borderColor ?? UIColor.systemBackground.cgColor
        self.autoLayout = autoLayout
        super.init(frame: CGRect(x: 0, y: 0, width: 140, height: 35))
        //        setupButton()
        
        tintColor = titleColor
        
        setTitle(title, for: .normal)
        backgroundColor = backgroundButtonColor
        clipsToBounds = clipsToBoundsOfButton
        alpha = alphaButton ?? 1
        layer.borderColor = borderColor ?? UIColor.systemBackground.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth ?? 0
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = autoLayout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc private func buttonTapped(){
        addTargetForButton()
    }
}
