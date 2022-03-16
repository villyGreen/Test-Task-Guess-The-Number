//
//  ViewController.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    let mainLabel = UILabel()
    let startButton = UIButton(type: .system)
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

extension StartViewController {
    private func setupElements() {
        view.addSubview(gradientView)
        gradientView.addSubview(mainLabel)
        gradientView.addSubview(startButton)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        gradientView.contentMode = .scaleAspectFill
        mainLabel.setupLabel(color: .white ,text: "Guess the number", alpha: 1, size: 24, width: 8)
        startButton.setupButton(color: .white, title: "Start", size: 20, tintColor: .black, cornerRadius: 11, width: 100)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    private func setupScreen() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainLabel.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 100),
            mainLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -100),
            startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        ])
    }
    @objc private func startGame() {
        let selectVc = SelectViewController()
        selectVc.modalTransitionStyle = .crossDissolve
        selectVc.modalPresentationStyle = .fullScreen
        self.present(selectVc, animated: true, completion: nil)
    }
}
