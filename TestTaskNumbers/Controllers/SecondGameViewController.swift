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
                                    to: .bottomLeading,
                                    startColor: #colorLiteral(red: 0.4522246663, green: 0.8549019694, blue: 0.3843184975, alpha: 1),
                                    endColor: #colorLiteral(red: 0.2823541543, green: 0.2818588128, blue: 0.9686274529, alpha: 1))
    
    var game = Game()
    var flag = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        print(game)
    }
    
    init?(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
        self.game.ComputerNumber = Int.random(in: 0...100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScreen()
    }
    deinit {
        print("gg")
    }
}
extension SecondGameViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.setupLabel(color: .white ,text: "Try № 2", alpha: 1, size: 20, width: 8)
        descriptionLabel.setupLabel(color: .white, text: "You are guessing", alpha: 1, size: 16, width: 4)
        answerLabel.setupLabel(color: .white, text: "Guess my number", alpha: 0.7, size: 13, width: 4)
        answerLabel.textAlignment = .center
        guessButton.setupButton(color: .white, title: "Guess", size: 20, tintColor: .black, cornerRadius: 11, width: 100)
        mainLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        numberTextField.textColor = .white
        numberTextField.placeholder = "0 - 100"
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFromTextField), for: .allEditingEvents)
        guessButton.addTarget(self, action: #selector(nextVc), for: .touchUpInside)
        guessButton.isEnabled = false
        let labelsStackView = UIStackView(arrangedSubviews: [descriptionLabel,numberTextField])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 13
        let buttonStackView = UIStackView(arrangedSubviews: [guessButton, answerLabel])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 13
        
        
        contentStackView = UIStackView(arrangedSubviews: [mainLabel, labelsStackView,buttonStackView])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        
        gradientView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupScreen() {
        NSLayoutConstraint.activate([
            guessButton.heightAnchor.constraint(equalToConstant: 30),
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 50),
            contentStackView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -50)
        ])
        
        contentStackView.spacing = view.frame.height / 4
    }
    
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
        let result = GameService.shared.youGuess(yourNumber: value! , ComputerNumber: game.ComputerNumber)
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
            guard let vc = ScoreViewController(game: game) else { return }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
