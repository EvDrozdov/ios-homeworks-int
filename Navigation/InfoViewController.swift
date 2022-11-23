//
//  InfoViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var termsOfUseButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            button.backgroundColor = .green
            button.setTitle("Правила", for: .normal)
            button.addTarget(self, action: #selector(self.didTapTermsOfUseButton), for: .touchUpInside)
            return button
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .yellow
            
            self.view.addSubview(self.termsOfUseButton)
            self.termsOfUseButton.center = self.view.center
        }
        
        @objc private func didTapTermsOfUseButton() {
            
            let alertController = UIAlertController(title: "Правила пользования", message: "Никуда нельзя нажимать", preferredStyle: .actionSheet)
            let firstAction = UIAlertAction(title: "Принимаю", style: .default) { _ in
                print("Принимаю")
            }
            let secondAction = UIAlertAction(title: "Не принимаю", style: .destructive) { _ in
                print("Не принимаю")
            }
           
            alertController.addAction(firstAction)
            alertController.addAction(secondAction)
            self.present(alertController, animated: true)

        }
}
