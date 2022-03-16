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
extension StartViewController {
    private func setupElements() {
        view.addSubview(gradientView)
        // Gradient View
        gradientView.addSubview(mainLabel)
        gradientView.addSubview(startButton)
        gradientView.contentMode = .scaleAspectFill
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        // Main Label
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.setupLabel(color: .white, text: "Guess the number", alpha: 1, size: 24, width: 8)
        // Start Button
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setupButton(color: .white, title: "Start",
                                size: 20, tintColor: .black,
                                cornerRadius: 11, width: 100)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    // MARK: - Setup Screen
    private func setupScreen() {
        NSLayoutConstraint.activate([
            // Gradient View
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // Main Label
            mainLabel.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 100),
            mainLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            // Start Button
            startButton.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -100),
            startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        ])
    }
    // MARK: - Transition
    @objc private func startGame() {
        let selectVc = SelectViewController()
        let window = UIApplication.shared.windows[0] as UIWindow
        UIView.transition(
            from: window.rootViewController!.view,
            to: selectVc.view,
            duration: 0.20,
            options: .transitionCrossDissolve,
            completion: { _ in
            window.rootViewController = selectVc
        })
    }
}
