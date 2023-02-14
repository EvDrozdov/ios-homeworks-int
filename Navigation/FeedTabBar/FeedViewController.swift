//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    var titile: NewTitle = NewTitle(title: "New Title")
    

     private lazy var stackView: UIStackView = {
         let stack = UIStackView()
         stack.distribution = .fillEqually
         stack.axis = .vertical
         stack.spacing = 10
         stack.translatesAutoresizingMaskIntoConstraints = false

         return stack
     }()

     private lazy var button1 = CustomButton(customTitle: "Button one") {
         self.postTap()
     }

     private lazy var button2 = CustomButton(customTitle: "Button two") {
         self.postTap()
     }

     private var checkTextField: UITextField = {
         let tf = UITextField()
         tf.layer.borderColor = UIColor.black.cgColor
         tf.layer.borderWidth = 1
         tf.translatesAutoresizingMaskIntoConstraints = false
         tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
         tf.leftViewMode = .always
         return tf
     }()

     private var checkLabel: UILabel = {
         let label = UILabel()
         label.text = "Wait..."
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()

     private lazy var checkButton = CustomButton(customTitle: "Check") {
         guard let checkedSecret = self.checkTextField.text else { return }

         if !checkedSecret.isEmpty {
             if FeedModel().check(word: checkedSecret) {
                 self.checkLabel.text = "Correct"
                 self.checkLabel.textColor = .green
             } else {
                 self.checkLabel.textColor = .red
                 self.checkLabel.text = "Wrong "
             }
         } else {
             self.checkLabel.text = "Empty "
         }
     }

     override func viewDidLoad() {
         super.viewDidLoad()
         setupSubviews()
     }

     private func postTap() {
         coordinator?.toPostViewController(send: titile )
     }

     private func setupSubviews() {
         view.backgroundColor = .white
         navigationItem.title = "Feed"
         
         view.addSubview(stackView)
         view.addSubview(checkLabel)
         view.addSubview(checkTextField)
         view.addSubview(checkButton)
         stackView.addArrangedSubview(button1)
         stackView.addArrangedSubview(button2)

         setupConstraints()
     }

     private func setupConstraints() {
         NSLayoutConstraint.activate([
             stackView.heightAnchor.constraint(equalToConstant: 90),
             stackView.widthAnchor.constraint(equalToConstant: 200),
             stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

             checkTextField.widthAnchor.constraint(equalToConstant: 300),
             checkTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             checkTextField.heightAnchor.constraint(equalToConstant: 50),
             checkTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 35),

             checkLabel.topAnchor.constraint(equalTo: checkTextField.bottomAnchor,constant: 20),
             checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

             checkButton.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 20),
             checkButton.heightAnchor.constraint(equalToConstant: 40),
             checkButton.widthAnchor.constraint(equalToConstant: 200),
             checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
     }
 }
