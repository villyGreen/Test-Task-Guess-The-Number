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
                                    toV: .bottomLeading,
                                    startColor: UIColor(hex: "BF64DA"),
                                    endColor: UIColor(hex: "3DACF7"))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScreen()
    }
}
// MARK: - Setup Elements
extension SelectViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        // Gradient View
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        // Main Label
        mainLabel.setupLabel(color: .white, text: "Guess the number",
                             alpha: 1, size: 20,
                             width: 8)
        mainLabel.textAlignment = .center
        // Start Button
        startButton.setupButton(color: .white, title: "Enter the number",
                                size: 20, tintColor: .black, cornerRadius: 11,
                                width: 100)
        startButton.alpha = 0.5
        startButton.isEnabled = false
        startButton.addTarget(self, action: #selector(nextVc), for: .touchUpInside)
        // Numbers StackView
        numberTextField.textColor = .white
        numberTextField.placeholder = "0 - 100"
        numberTextField.delegate = self
        numberTextField.keyboardType = UIKeyboardType.numberPad
        numberTextField.addTarget(self, action: #selector(textFromTextField), for: .allEditingEvents)
        // ContentStackView
        contentStackView = UIStackView(arrangedSubviews: [mainLabel, numberTextField, startButton])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.addSubview(contentStackView)
    }
    // MARK: - Setup Screen
    private func setupScreen() {
        NSLayoutConstraint.activate([
            // Gradient View
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // Content Stack View
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
        guard  let firstVc = FirstGameViewController(number: numberTextField.text!) else { return }
        let window = UIApplication.shared.windows[0] as UIWindow
        UIView.transition(
            from: window.rootViewController!.view,
            to: firstVc.view,
            duration: 0.20,
            options: .transitionCrossDissolve,
            completion: { _ in
                window.rootViewController = firstVc
        })
    }
}
