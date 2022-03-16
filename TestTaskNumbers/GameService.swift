//
//  GameService.swift
//  TestTaskNumbers
//
//  Created by zz on 16.03.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//

import UIKit

class GameService {
    static let shared = GameService()
    
    func computerGuess(numOne: Int, numTwo: Int) -> Int {
        let number = Int.random(in: numOne...numTwo)
        return number
    }
    func youGuess(yourNumber: Int, computerNumber: Int) -> Int {
        var result = 0
        if yourNumber > computerNumber {
            result = 1
        }
        if yourNumber < computerNumber {
            result = 2
        }
        if yourNumber == computerNumber {
            result = 3
        }
        return result
    }
}
