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
    private var inputHandler = InputHandler()
    
    init() {
        firstNumber = 0
        secondNumber = 0
        operation = CalculatorOperations.none
        condition = CalculatorConditions.ready
    }
    
    // MARK: - Functions
    // MARK: Input handling
    
    func insertNumber(num: String) -> String {
        guard let numInDouble = Double(inputHandler.digitAppend(num)) else {
            return "Input handling error"
        }
        switch condition {
        case .firstNumberEnter:
            firstNumber = numInDouble
            return "\(firstNumber)"
        case .secondNumberEnter:
            secondNumber = numInDouble
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
        guard let numInDouble = Double(inputHandler.dotAppend()) else {
            return "Input handling error"
        }
        switch condition {
        case .firstNumberEnter:
                firstNumber = numInDouble
                return "\(firstNumber)"
        case .secondNumberEnter:
                secondNumber = numInDouble
                return "\(secondNumber)"
        case .ready:
            firstNumber = 0
            condition = .firstNumberEnter
            return "\(firstNumber)"
        case .equalResult:
            _ = ac()
            return "\(firstNumber)"
        }
    }
    
    // MARK: Arithmetic logic
    
    func unary() -> String {
        guard let numInDouble = Double(inputHandler.minusPlus()) else {
            return "Input handling error"
        }
        switch condition {
        case .firstNumberEnter:
            firstNumber = numInDouble
            return "\(firstNumber)"
        case .secondNumberEnter:
            secondNumber = numInDouble
            return "\(secondNumber)"
        case .ready:
            condition = .firstNumberEnter
            firstNumber = numInDouble
            return "\(firstNumber)"
        case .equalResult:
            changeState(toCondition: .firstNumberEnter)
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
            changeState(toCondition: .firstNumberEnter)
            return procent()
        }
    }
    
    func ac() -> String {
        if condition == .secondNumberEnter {
            if secondNumber != 0 {
            secondNumber = 0
            inputHandler.clearAll()
            return "\(secondNumber)"
            } else {
                firstNumber = 0
                secondNumber = 0
                operation = CalculatorOperations.none
                changeState(toCondition: .ready)
                return "\(firstNumber)"
            }
        } else {
            firstNumber = 0
            secondNumber = 0
            operation = CalculatorOperations.none
            changeState(toCondition: .ready)
            return "\(firstNumber)"
        }
    }
    
    func operate(type: CalculatorOperations) -> String {
        operation = type
        switch condition {
        case .firstNumberEnter:
            changeState(toCondition: .secondNumberEnter)
            return "\(firstNumber)"
        case .secondNumberEnter:
            let result = equal()
            changeState(toCondition: .secondNumberEnter)
            return result
        case .ready:
            return "\(firstNumber)"
        case .equalResult:
            changeState(toCondition: .secondNumberEnter)
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
            changeState(toCondition: .equalResult)
        case .addition:
            firstNumber = firstNumber + secondNumber
            changeState(toCondition: .equalResult)
        case .division:
            firstNumber = firstNumber / secondNumber
            changeState(toCondition: .equalResult)
        case .subtraction:
            firstNumber = firstNumber - secondNumber
            changeState(toCondition: .equalResult)
        }
        return "\(firstNumber)"
    }
}

// MARK: - Helpers

extension Calculator {
    func changeState(toCondition state: CalculatorConditions) {
        condition = state
        inputHandler.clearAll()
    }
    
    func currentStatusReturn() -> (CalculatorConditions, CalculatorOperations) {
        return (condition, operation)
    }
}
