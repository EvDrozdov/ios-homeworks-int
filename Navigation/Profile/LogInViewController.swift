//
//  LogInViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 04.10.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    static var loginFactoryDelegate: LoginFactory?
    
    let concurrentQuee = DispatchQueue(label: "queueForPassword",
                                       qos: .userInteractive,
                                       attributes: [.concurrent])
    
    private lazy var selectPasswordButton: CustomButton = {
        let buttom = CustomButton(title: "Подобрать пароль", titleColor: .white, backgroundButtonColor: .blue, clipsToBoundsOfButton: true, cornerRadius: 10, autoLayout: false)
        buttom.addTargetForButton = { self.makePassword() }
        return buttom
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.color = .black
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
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
        stackView.addArrangedSubview(selectPasswordButton)
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
        textField.text = "Evgeny"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocorrectionType = .no
        return textField
        
    }()
    
    private lazy var passwordTextField: UITextField = {
        let pwTextField = UITextField()
        pwTextField.text = "Drozdov"
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
        
        guard let checkResults = LogInViewController.loginFactoryDelegate?.makeLoginInspector().check(login: loginTextField.text!, pass: passwordTextField.text!) else {
            return }
        
        if checkResults {
            guard let user = Checker.shared.user else { return }
            let profileVC = ProfileViewController()
            profileVC.newUser = user
            navigationController?.pushViewController(profileVC, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Unknown login", message: "Please, enter correct user login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(textFieldStackView)
        scrollView.addSubview(vkImageView)
        view.addSubview(activityIndicator)
        
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
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.leadingAnchor.constraint(equalTo: textFieldStackView.trailingAnchor, constant: -26),
            activityIndicator.centerYAnchor.constraint(equalTo: textFieldStackView.centerYAnchor, constant: 26),
            
            
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
    
    @objc private func makePassword(){
        // показали AI
        setupActivityIndicator()
        // создали переменную, в которую вернем с потока сгенерированный пароль (брутфорс)
        var setPasswordBetweenQueue: String = ""
        
        // запустили подбор пароля, его вернем
        concurrentQuee.async {
            setPasswordBetweenQueue = self.comparePasswords()
            // синхронизировали потоки
            DispatchQueue.main.async {
                self.passwordTextField.text = setPasswordBetweenQueue
                self.passwordTextField.isSecureTextEntry = false
                self.deSetupActivityIndicator()
            }
        }
    }
    
    private func comparePasswords() -> String {
        // количество символов задаем
        let randomPassword = String.createRandomPassword(for: 3)
        let brutePassword = BruteForce().bruteForce(passwordToUnlock: randomPassword)
        return brutePassword
    }
    
    private func setupActivityIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func deSetupActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    @objc private func hideKeyboard() {
        
        view.endEditing(true)
        scrollView.setContentOffset(.zero, animated: true)
        
    }
    
}


