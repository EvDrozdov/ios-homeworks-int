//
//  LogInViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 04.10.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        
    }()
    
    private lazy var vkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.setCustomSpacing(0.5, after: loginTextField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email or Phone"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocorrectionType = .no
        return textField
        
    }()
    
    private lazy var passwordTextField: UITextField = {
        let pwTextField = UITextField()
        pwTextField.backgroundColor = .systemGray6
        pwTextField.placeholder = "Password"
        pwTextField.textColor = .black
        pwTextField.font = .systemFont(ofSize: 16, weight: .regular)
        pwTextField.autocorrectionType = .no
        pwTextField.isSecureTextEntry = true
        return pwTextField
        
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(moveToProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didHideKeyboard(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //loginTextField.becomeFirstResponder()
        
    }
    
    @objc func moveToProfile() {
        
        let viewController = ProfileViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(textFieldStackView)
        scrollView.addSubview(vkImageView)
        
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),


            vkImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            vkImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            vkImageView.widthAnchor.constraint(equalToConstant: 100),
            vkImageView.heightAnchor.constraint(equalToConstant: 100),
            vkImageView.bottomAnchor.constraint(equalTo: textFieldStackView.topAnchor, constant: -120),


            textFieldStackView.topAnchor.constraint(equalTo: vkImageView.bottomAnchor, constant: 120),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 100),


            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor),
            loginButton.leadingAnchor.constraint(equalTo: textFieldStackView.leadingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)

            ])
        
        
    }
    
    private func setupGesture() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonPointY = loginButton.frame.origin.y + loginButton.frame.height
            let keyboardOriginY = view.frame.height - keyboardHeight
            
            let offset = keyboardOriginY <= loginButtonPointY ? loginButtonPointY - keyboardOriginY + 16 : 0
            
            scrollView.contentOffset = CGPoint(x: 0, y: offset)
            
        }
    }
        
        @objc private func didHideKeyboard(_ notification: Notification) {
            
            hideKeyboard()
            
        }
        
        @objc private func hideKeyboard() {
            
            view.endEditing(true)
            scrollView.setContentOffset(.zero, animated: true)
            
        }
        
    }
    

