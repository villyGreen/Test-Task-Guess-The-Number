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
                                    to: .bottomLeading,
                                    startColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                                    endColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
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
    deinit {
           print("gg")
       }
    
}
extension ScoreViewController: UITextFieldDelegate {
    private func setupElements() {
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.setupLabel(color: .white ,text: "Scores", alpha: 1, size: 20, width: 8)
        mainMenuButton.setupButton(color: .white, title: "Main menu", size: 20, tintColor: .black, cornerRadius: 11, width: 100)
        yourScoreLabel.setupLabel(color: .white, text: "Your's tries count: \(game.yourCount)", alpha: 0.9, size: 14, width: 4)
        computerScoreLabel.setupLabel(color: .white, text: "Computer's tries count: \(game.computerCount)", alpha: 0.8, size: 14, width: 4)
        winLabel.setupLabel(color: .white, text: text, alpha: 0.9, size: 15, width: 4)
        winLabel.textAlignment = .center
        yourScoreLabel.textAlignment = .center
        computerScoreLabel.textAlignment = .center
        mainLabel.textAlignment = .center
        mainMenuButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        let labelsStackView = UIStackView(arrangedSubviews: [yourScoreLabel, computerScoreLabel])
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 13
        let buttonStackView = UIStackView(arrangedSubviews: [winLabel,mainMenuButton])
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
            mainMenuButton.heightAnchor.constraint(equalToConstant: 30),
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
        let vc = StartViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
