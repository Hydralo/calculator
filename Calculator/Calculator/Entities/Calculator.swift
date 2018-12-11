//
//  Calculator.swift
//  Calculator
//
//  Created by Рабочий on 02/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

// MARK: Constants & Initializer

enum CalculatorConditions {
    case firstNumberEnter
    case secondNumberEnter
    case ready
    case equalResult
}

enum CalculatorOperations {
    case none
    case addition
    case subtraction
    case division
    case multiplication
}

class Calculator {
    private var firstNumber: Double
    private var secondNumber: Double
    private var condition: CalculatorConditions
    private var operation: CalculatorOperations
    
    init() {
        firstNumber = 0
        secondNumber = 0
        operation = CalculatorOperations.none
        condition = CalculatorConditions.ready
    }
    
    // MARK: - Functions
    // MARK: Input hangling
    
    func insertNumber(num: String) -> String {
        guard let numInDouble = Double(num) else {
            return "Convertation to double errror"
        }
        
        switch condition {
        case .firstNumberEnter:
            if(firstNumber < 999999999) {
                if(firstNumber == 0) {
                    firstNumber = numInDouble
                }
                else {
                    firstNumber = firstNumber * 10 + numInDouble
                }
            }
            return "\(firstNumber)"
        case .secondNumberEnter:
            if(secondNumber < 999999999) {
                if(secondNumber == 0) {
                    secondNumber = numInDouble
                }
                else {
                    secondNumber = secondNumber * 10 + numInDouble
                }
            }
            return "\(secondNumber)"
        case .ready:
            if(numInDouble == 0) {
                return "\(numInDouble)"
            }
            firstNumber = numInDouble
            condition = .firstNumberEnter
            return "\(firstNumber)"
        case .equalResult:
            _ = ac()
            return insertNumber(num: num)
        }
    }
    
    func insertKomma() -> String {
        switch condition {
        case .firstNumberEnter:
            if firstNumber < 999999999 {
                return "\(firstNumber)"
            }
        case .secondNumberEnter:
            if secondNumber < 999999999 {
                return "\(secondNumber)"
            }
        case .ready:
            firstNumber = 0
            condition = .firstNumberEnter
            return "\(firstNumber)"
        case .equalResult:
            _ = ac()
            return "\(firstNumber)"
        }
    return ""
    }
    
    // MARK: Arithmetic
    
    func unary() -> String {
        switch condition {
        case .firstNumberEnter:
            if(firstNumber != 0) {
                firstNumber *= -1
            }
            return "\(firstNumber)"
        case .secondNumberEnter:
            if(secondNumber != 0) {
                secondNumber *= -1
            }
            return "\(secondNumber)"
        case .ready:
            condition = .firstNumberEnter
            return "\(firstNumber)"
        case .equalResult:
            condition = .firstNumberEnter
            secondNumber = 0
            return unary()
        }
    }
    
    func procent() -> String {
        switch condition {
        case .firstNumberEnter:
            secondNumber = 100
            operation = .division
            return equal()
        case .secondNumberEnter:
            firstNumber = secondNumber
            secondNumber = 100
            operation = .division
            return equal()
        case .ready:
            return "\(firstNumber)"
        case .equalResult:
            condition = .firstNumberEnter
            return procent()
        }
    }
    
    func ac() -> String {
        firstNumber = 0
        secondNumber = 0
        operation = CalculatorOperations.none
        condition = CalculatorConditions.ready
        return "\(firstNumber)"
    }
    
    func operate(type: CalculatorOperations) -> String {
        operation = type
        switch condition {
        case .firstNumberEnter:
            condition = .secondNumberEnter
            return "\(firstNumber)"
        case .secondNumberEnter:
            let result = equal()
            condition = .secondNumberEnter
            return result
        case .ready:
            return "\(firstNumber)"
        case .equalResult:
            condition = .secondNumberEnter
            secondNumber = 0
            return "\(firstNumber)"
        }
    }
    
    func equal() -> String {
        switch operation {
        case .none:
            return "\(firstNumber)"
        case .multiplication:
            firstNumber = firstNumber * secondNumber
            condition = .equalResult
        case .addition:
            firstNumber = firstNumber + secondNumber
            condition = .equalResult
        case .division:
            firstNumber = firstNumber / secondNumber
            condition = .equalResult
        case .subtraction:
            firstNumber = firstNumber - secondNumber
            condition = .equalResult
        }
        return "\(firstNumber)"
    }
}
