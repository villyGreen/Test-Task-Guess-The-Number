//
//  ScoreViewController.swift
//  TestTaskNumbers
//
//  Created by zz on 16.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    let mainLabel = UILabel()
    var contentStackView =  UIStackView()
    let yourScoreLabel = UILabel()
    let computerScoreLabel = UILabel()
    let winLabel = UILabel()
    let mainMenuButton = UIButton(type: .system)
    let gradientView = GradientView(from: .topTrailing,
                                    toV: .bottomLeading,
                                    startColor: UIColor(hex: "EC3C1A"),
                                    endColor: UIColor(hex: "2D038F"))
    var game = Game()
    var text = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        whoWinner()
        setupElements()
    }
    init?(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScreen()
    }
}
// MARK: - Setup Screen
extension ScoreViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        // Gradient View
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        // Main Label
        mainLabel.setupLabel(color: .white, text: "Scores",
                             alpha: 1, size: 20, width: 8)
        mainLabel.textAlignment = .center
        // Main Menu button
        mainMenuButton.setupButton(color: .white, title: "Main menu", size: 20,
                                   tintColor: .black, cornerRadius: 11, width: 100)
        mainMenuButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        // Your Score Label
        yourScoreLabel.setupLabel(color: .white,
                                  text: "Your's tries count: \(game.yourCount)",
            alpha: 0.9, size: 14, width: 4)
        // Computer Score Label
        computerScoreLabel.setupLabel(color: .white,
                                      text: "Computer's tries count: \(game.computerCount)",
            alpha: 0.8, size: 14, width: 4)
        computerScoreLabel.textAlignment = .center
        // Win Label
        winLabel.setupLabel(color: .white, text: text, alpha: 0.9, size: 15, width: 4)
        winLabel.textAlignment = .center
        // Your Score Label
        yourScoreLabel.textAlignment = .center
        // Labels Stack View
        let labelsStackView = UIStackView(arrangedSubviews: [yourScoreLabel, computerScoreLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 13
        // Buttons Stack View
        let buttonStackView = UIStackView(arrangedSubviews: [winLabel, mainMenuButton])
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
            // Main Menu button
            mainMenuButton.heightAnchor.constraint(equalToConstant: 30),
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
    private func whoWinner() {
        if game.yourCount < game.computerCount {
            text = "You win"
        }
        if game.yourCount > game.computerCount {
            text = "You lose"
        }
        if game.yourCount == game.computerCount {
            text = "Draw"
        }
    }
    @objc private func newGame() {
        let startVc = StartViewController()
        let window = UIApplication.shared.windows[0] as UIWindow
        UIView.transition(
            from: window.rootViewController!.view,
            to: startVc.view,
            duration: 0.20,
            options: .transitionCrossDissolve,
            completion: { _ in
                window.rootViewController = startVc
        })
    }
}
