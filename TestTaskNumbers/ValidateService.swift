//
//  ValidateService.swift
//  TestTaskNumbers
//
//  Created by zz on 15.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class ValidateService {
    static let shared = ValidateService()
    func validateTextField(_ text: String?) -> Bool {
        if text!.count > 1 {
            if text!.first == "0" {
                return false
            }
        }
        guard let text = text, text != " " else { return false }
        guard let number = Int(text) else { return false }
        guard number <= 100, number >= 0 else { return false }
        return true
    }
}
