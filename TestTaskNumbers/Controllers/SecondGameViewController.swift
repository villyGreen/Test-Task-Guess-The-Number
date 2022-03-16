//
//  SecondGameViewController.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class SecondGameViewController: UIViewController {
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    var contentStackView =  UIStackView()
    let answerLabel = UILabel()
    let guessButton = UIButton(type: .system)
    let numberTextField = UITextField(fontTf: UIFont(name: "Gill Sans", size: 20))
    let gradientView = GradientView(from: .topTrailing,
                                    toV: .bottomLeading,
                                    startColor: UIColor(hex: "73DA62"),
                                    endColor: UIColor(hex: "4848F7"))
    var game = Game()
    var flag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    init?(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
        self.game.computerNumber = Int.random(in: 0...100)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScreen()
    }
}
// MARK: - Setup Elements
extension SecondGameViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        // Gradient View
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        // Main Label
        mainLabel.setupLabel(color: .white, text: "Try № 2",
                             alpha: 1, size: 20, width: 8)
        mainLabel.textAlignment = .center
        // Description Label
        descriptionLabel.setupLabel(color: .white, text: "You are guessing", alpha: 1, size: 16, width: 4)
        descriptionLabel.textAlignment = .center
        // Answer Label
        answerLabel.setupLabel(color: .white, text: "Guess my number", alpha: 0.7, size: 13, width: 4)
        answerLabel.textAlignment = .center
        // Guess Button
        guessButton.setupButton(color: .white, title: "Guess", size: 20,
                                tintColor: .black, cornerRadius: 11, width: 100)
        guessButton.addTarget(self, action: #selector(nextVc), for: .touchUpInside)
        guessButton.isEnabled = false
        // Number Text Field
        numberTextField.textColor = .white
        numberTextField.placeholder = "0 - 100"
        numberTextField.delegate = self
        numberTextField.keyboardType = UIKeyboardType.numberPad
        numberTextField.addTarget(self, action: #selector(textFromTextField), for: .allEditingEvents)
        // Labels Stack View
        let labelsStackView = UIStackView(arrangedSubviews: [descriptionLabel, numberTextField])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 13
        // Buttons Stack View
        let buttonStackView = UIStackView(arrangedSubviews: [guessButton, answerLabel])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 13
        // Content Stack View
        contentStackView = UIStackView(arrangedSubviews: [mainLabel, labelsStackView, buttonStackView])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.addSubview(contentStackView)
    }
    // MARK: - Setup Screen
    private func setupScreen() {
        NSLayoutConstraint.activate([
            // Guess Button
            guessButton.heightAnchor.constraint(equalToConstant: 30),
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
        contentStackView.spacing = view.frame.height / 4
    }
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @objc func textFromTextField() {
        if ValidateService.shared.validateTextField(numberTextField.text) {
            guessButton.isEnabled = true
            guessButton.alpha = 1
        } else {
            guessButton.isEnabled = false
            guessButton.alpha = 0.5
        }
    }
    @objc private func nextVc() {
        let value = Int(numberTextField.text!)
        let result = GameService.shared.youGuess(yourNumber: value!, computerNumber: game.computerNumber)
        switch result {
        case 1:
            answerLabel.text = "Your number is bigger than mine"
            game.yourCount += 1
        case 2:
            answerLabel.text = "Your number is less than mine"
            game.yourCount += 1
        case 3:
            answerLabel.text = "Yes, that's my number"
            flag = true
        default:
            break
        }
        if flag {
            guard let scoreVc = ScoreViewController(game: game) else { return }
            let window = UIApplication.shared.windows[0] as UIWindow
            UIView.transition(
                from: window.rootViewController!.view,
                to: scoreVc.view,
                duration: 0.20,
                options: .transitionCrossDissolve,
                completion: { _ in
                    window.rootViewController = scoreVc
            })
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
        return true
    }
}
