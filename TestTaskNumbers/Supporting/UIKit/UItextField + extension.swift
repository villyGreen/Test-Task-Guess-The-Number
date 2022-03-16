//
//  UItextField + extension.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//
import UIKit
extension UITextField {
    convenience init(fontTf: UIFont?) {
        self.init()
        self.font = fontTf
        self.borderStyle = .none
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = #colorLiteral(red: 0.2161727514, green: 0.2161727514, blue: 0.2161727514, alpha: 0.411300453)
        self.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
        func disableAutoFill() {
            if #available(iOS 12, *) {
                textContentType = .oneTimeCode
            } else {
                textContentType = .init(rawValue: "")
            }
        }
}
