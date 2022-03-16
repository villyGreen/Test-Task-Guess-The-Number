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
    
    func ComputerGuess(NumOne: Int, numTwo: Int) -> Int {
        let number = Int.random(in: NumOne...numTwo)
        return number
    }
    
    func youGuess(yourNumber: Int, ComputerNumber: Int) -> Int {
        var result = 0
        if yourNumber > ComputerNumber {
            result = 1
        }
        if yourNumber < ComputerNumber {
            result = 2
        }
        if yourNumber == ComputerNumber {
            result = 3
        }
        return result
    }
}
