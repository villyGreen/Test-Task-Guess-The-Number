//
//  UIButton + extension.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

extension UIButton {
func setupButton(color: UIColor, title: String, size : CGFloat, tintColor: UIColor, cornerRadius: CGFloat, width: CGFloat) {
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        self.tintColor = tintColor
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = UIFont(name: "Gill Sans", size: size)
        self.titleEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
