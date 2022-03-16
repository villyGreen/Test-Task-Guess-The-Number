//
//  UILabel + extension.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

extension UILabel {
    func setupLabel(color: UIColor, text: String, alpha: CGFloat, size: CGFloat, width: CGFloat?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textColor = color
        self.alpha = alpha
        self.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: width ?? 0.3))
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
    }
}
