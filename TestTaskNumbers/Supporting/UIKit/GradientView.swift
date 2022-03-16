//
//  GradientView.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit
class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing
        var point: CGPoint {
            switch self {
            case .topLeading:
                return CGPoint(x: 0, y: 0)
            case .leading:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeading:
                return CGPoint(x: 0, y: 1.0)
            case .top:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topTrailing:
                return CGPoint(x: 1.0, y: 0.0)
            case .trailing:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomTrailing:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setupGradientColors(startColor: startColor, endColor: endColor)
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setupGradientColors(startColor: startColor, endColor: endColor)
        }
    }
    init(from: Point, toV: Point, startColor: UIColor?, endColor: UIColor?) {
        self.init()
        setupGradient(from: from, toV: toV, startColor: startColor, endColor: endColor)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    private func setupGradient(from: Point, toV: Point, startColor: UIColor?, endColor: UIColor?) {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors(startColor: startColor, endColor: endColor)
        gradientLayer.startPoint = from.point
        gradientLayer.endPoint = toV.point
    }
    private func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient(from: .leading, toV: .trailing, startColor: startColor, endColor: endColor)
    }
}
