//
//  File.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit


class SelectViewController: UIViewController {
    
    let mainLabel = UILabel()
    var contentStackView =  UIStackView()
    let startButton = UIButton(type: .system)
    let numberTextField = UITextField(fontTf: UIFont(name: "Gill Sans", size: 20))
    let gradientView = GradientView(from: .topTrailing,
                                    to: .bottomLeading,
                                    startColor: #colorLiteral(red: 0.7507003285, green: 0.391231853, blue: 0.8549019694, alpha: 1),
                                    endColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScreen()
    }
    deinit {
        print("gg")
    }
}
extension SelectViewController: UITextFieldDelegate {
    
    private func setupElements() {
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.setupLabel(color: .white ,text: "Guess the number", alpha: 1, size: 20, width: 8)
        mainLabel.textAlignment = .center
        startButton.setupButton(color: .white, title: "Enter the number", size: 20, tintColor: .black, cornerRadius: 11, width: 100)
        startButton.alpha = 0.5
        startButton.isEnabled = false
        contentStackView = UIStackView(arrangedSubviews: [mainLabel, numberTextField, startButton])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        numberTextField.textColor = .white
        numberTextField.placeholder = "0 - 100"
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFromTextField), for: .allEditingEvents)
        startButton.addTarget(self, action: #selector(nextVc), for: .touchUpInside)
        numberTextField.keyboardType = UIKeyboardType.numberPad
        gradientView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupScreen() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 50),
            contentStackView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -50)
        ])
        
        contentStackView.spacing = view.frame.height / 3
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func textFromTextField() {
        if ValidateService.shared.validateTextField(numberTextField.text) {
            startButton.isEnabled = true
            startButton.alpha = 1
        } else {
            startButton.isEnabled = false
            startButton.alpha = 0.5
        }
    }
    
    @objc private func nextVc() {
        guard let vc = FirstGameViewController(number: numberTextField.text!) else  { return }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
