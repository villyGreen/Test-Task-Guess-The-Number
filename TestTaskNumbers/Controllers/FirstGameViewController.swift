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
    @objc let moreButton = UIButton(type: .system)
    let myNumberLabel = UILabel()
    let gradientView = GradientView(from: .topTrailing,
                                    to: .bottomLeading,
                                    startColor: #colorLiteral(red: 0.4522246663, green: 0.8549019694, blue: 0.3843184975, alpha: 1),
                                    endColor: #colorLiteral(red: 0.2823541543, green: 0.2818588128, blue: 0.9686274529, alpha: 1))
    var number = Int()
    var answer = Int()
    var minValue = 100
    var maxValue = 0
    var isMin = false
    var isMax = false
    
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
    deinit {
        print("gg")
    }
}
extension FirstGameViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.setupLabel(color: .white ,text: "Try № 1", alpha: 1, size: 20, width: 8)
        descriptionLabel.setupLabel(color: .white, text: "Your number is \(game.yourNumber)", alpha: 1, size: 16, width: 4)
        computerAnswer.setupLabel(color: .white, text: "The computer thinks ...", alpha: 1, size: 16, width: 4)
        myNumberLabel.setupLabel(color: .white, text: "My number is ...", alpha: 0.8, size: 13, width: 4)
        mainLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        computerAnswer.textAlignment = .center
        lessButton.setupButton(color: .white, title: "<", size: 20, tintColor: .black, cornerRadius: 10, width: 100)
        equalButton.setupButton(color: .white, title: "=", size: 20, tintColor: .black, cornerRadius: 10, width: 100)
        moreButton.setupButton(color: .white, title: ">", size: 20, tintColor: .black, cornerRadius: 10, width: 10)
        equalButton.addTarget(self, action: #selector(nextVc), for: .touchUpInside)
        lessButton.addTarget(self, action: #selector(lessNumber), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreNumber), for: .touchUpInside)
        let buttonsStackView = UIStackView(arrangedSubviews: [lessButton, equalButton, moreButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillEqually
        let sideStackView = UIStackView(arrangedSubviews: [myNumberLabel, buttonsStackView])
        sideStackView.axis = .vertical
        sideStackView.spacing = 7
        
        let labelsStackView = UIStackView(arrangedSubviews: [descriptionLabel, computerAnswer])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 20
        contentStackView = UIStackView(arrangedSubviews: [mainLabel, labelsStackView, sideStackView])
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
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
        
        contentStackView.spacing = view.frame.height / 4
    }
    
    private func computerGuess(numOne: Int, numTwo: Int) {
        answer =  GameService.shared.ComputerGuess(NumOne: numOne, numTwo: numTwo)
        let timeOfComputerAnswer = Int.random(in: 1...3)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeOfComputerAnswer)) {
            self.computerAnswer.text = "Computer answer is \(self.answer)"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func nextVc() {
        
        if game.yourNumber == answer {
            guard let vc = SecondGameViewController(game: game) else { return }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    @objc private func lessNumber() {
        computerAnswer.text = "The computer thinks ..."
        computerGuess(numOne: maxValue, numTwo: answer)
        game.computerCount += 1
        if answer > game.yourNumber {
        minValue = answer
        }
    }
    @objc private func moreNumber() {
        computerAnswer.text = "The computer thinks ..."
        computerGuess(numOne: answer, numTwo: minValue)
        game.computerCount += 1
        if answer < game.yourNumber {
            maxValue = answer
        }
    }
}
