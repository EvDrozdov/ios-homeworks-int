//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгений Дроздов on 30.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var timer: Timer?
    private var countOfUnsecTr = 0.0
    
    
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
        tf.addTarget(self, action: #selector(startTimer), for: .allTouchEvents)
        tf.leftViewMode = .always
        return tf
    }()
    
    private var checkLabel: UILabel = {
        let label = UILabel()
        label.text = "Wait..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc private func startTimer(){
            //  даем 15 с на ввод слова пользователю. Если не успел, то поднимаем Аларм и считаем такие алармы
            // таймер (счетчик) отключаем только тогда, когда введено слово + отправлено на проверку
            if timer == nil {
                timer = Timer(timeInterval: 15.0,
                              target: self,
                              selector: #selector(alarmNote),
                              userInfo: nil,
                              repeats: true)
                RunLoop.main.add(timer!, forMode: .default)
            }}

        @objc private func alarmNote(){
            countOfUnsecTr += 1
            let alarm = UIAlertController(title: "Время для проверки слова истекло",
                                          message: "Попробуйте снова, но быстрее",
                                          preferredStyle: .alert)
            let alarmAction = UIAlertAction(title: "ОК",
                                            style: .default)
            alarm.addAction(alarmAction)
            present(alarm, animated: true)
        }
    
    private lazy var checkButton = CustomButton(customTitle: "Check") {
        guard let checkedSecret = self.checkTextField.text else { return }
        
        if !checkedSecret.isEmpty {
            if FeedModel().check(word: checkedSecret) {
                self.checkLabel.text = "Correct"
                self.checkLabel.textColor = .green
                self.timer?.invalidate()
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
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
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
