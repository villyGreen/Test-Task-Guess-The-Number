//
//  FirstgameViewCotroller.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//
import UIKit

class FirstGameViewController: UIViewController {
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let computerAnswer = UILabel()
    var contentStackView =  UIStackView()
    let lessButton = UIButton(type: .system)
    let equalButton = UIButton(type: .system)
    let moreButton = UIButton(type: .system)
    let myNumberLabel = UILabel()
    let gradientView = GradientView(from: .topTrailing,
                                    toV: .bottomLeading,
                                    startColor: UIColor(hex: "73DA62"),
                                    endColor: UIColor(hex: "4848F7"))
    var number = Int()
    var answer = Int()
    var minValue = 100
    var maxValue = 0
    var game = Game()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        computerGuess(numOne: 0, numTwo: 100)
    }
    init?(number: String) {
        super.init(nibName: nil, bundle: nil)
        game.yourNumber = Int(number)!
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
extension FirstGameViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        // Gradient View
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        // Main Label
        mainLabel.setupLabel(color: .white, text: "Try № 1",
                             alpha: 1, size: 20, width: 8)
        mainLabel.textAlignment = .center
        // Description Label
        descriptionLabel.setupLabel(color: .white,
                                    text: "Your number is \(game.yourNumber)",
            alpha: 1, size: 16, width: 4)
        descriptionLabel.textAlignment = .center
        // ComputerAnswer
        computerAnswer.setupLabel(color: .white, text: "The computer thinks ...", alpha: 1, size: 16, width: 4)
        computerAnswer.textAlignment = .center
        // MyNumberLabel
        myNumberLabel.setupLabel(color: .white, text: "My number is ...", alpha: 0.8, size: 13, width: 4)
        // Buttons
        lessButton.setupButton(color: .white, title: "<", size: 20, tintColor: .black, cornerRadius: 10, width: 100)
        equalButton.setupButton(color: .white, title: "=", size: 20, tintColor: .black, cornerRadius: 10, width: 100)
        moreButton.setupButton(color: .white, title: ">", size: 20, tintColor: .black, cornerRadius: 10, width: 10)
        // Buttons targets
        equalButton.addTarget(self, action: #selector(nextVc), for: .touchUpInside)
        lessButton.addTarget(self, action: #selector(lessNumber), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreNumber), for: .touchUpInside)
        // Buttons Stack View
        let buttonsStackView = UIStackView(arrangedSubviews: [lessButton, equalButton, moreButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillEqually
        // Side Stack View
        let sideStackView = UIStackView(arrangedSubviews: [myNumberLabel, buttonsStackView])
        sideStackView.axis = .vertical
        sideStackView.spacing = 7
        // Labels Stack View
        let labelsStackView = UIStackView(arrangedSubviews: [descriptionLabel, computerAnswer])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 20
        // Content Stack View
        contentStackView = UIStackView(arrangedSubviews: [mainLabel, labelsStackView, sideStackView])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        gradientView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
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
        contentStackView.spacing = view.frame.height / 4
    }
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK: - Transition
    @objc private func nextVc() {
        if game.yourNumber == answer {
            guard let secondVc = SecondGameViewController(game: game) else { return }
            let window = UIApplication.shared.windows[0] as UIWindow
            UIView.transition(
                from: window.rootViewController!.view,
                to: secondVc.view,
                duration: 0.20,
                options: .transitionCrossDissolve,
                completion: { _ in
                    window.rootViewController = secondVc
            })
        }
    }
    // MARK: - Buttons Targets
    @objc private func lessNumber() {
        computerAnswer.text = "The computer thinks ..."
        if answer >= game.yourNumber {
            minValue = answer
        }
        computerGuess(numOne: maxValue, numTwo: answer)
        game.computerCount += 1
    }
    @objc private func moreNumber() {
        computerAnswer.text = "The computer thinks ..."
        if answer <= game.yourNumber {
            maxValue = answer
        }
        computerGuess(numOne: answer, numTwo: minValue)
        game.computerCount += 1
    }
    private func computerGuess(numOne: Int, numTwo: Int) {
        answer =  GameService.shared.computerGuess(numOne: numOne, numTwo: numTwo)
        let timeOfComputerAnswer = Int.random(in: 1...3)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeOfComputerAnswer)) {
            self.computerAnswer.text = "Computer answer is \(self.answer)"
        }
    }
}
