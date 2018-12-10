//
//  Calculator.swift
//  Calculator
//
//  Created by Рабочий on 02/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

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
    private var firstNumber: String
    private var secondNumber: String
    private var condition: CalculatorConditions
    private var operation: CalculatorOperations
    
    init() {
        firstNumber = "0"
        secondNumber = "0"
        operation = CalculatorOperations.none
        condition = CalculatorConditions.ready
    }
    
    func insertNumber(num: String) -> String {
        switch condition {
        case .firstNumberEnter:
            if(LabelController.charactersCountWithKomma(text: firstNumber) < 9) {
                if(firstNumber == "0") {
                    firstNumber = num
                }
                else {
                    firstNumber += num
                }
            }
            return firstNumber
        case .secondNumberEnter:
            if(LabelController.charactersCountWithKomma(text: secondNumber) < 9) {
                if(secondNumber == "0") {
                    secondNumber = num
                }
                else {
                    secondNumber += num
                }
            }
            return secondNumber
        case .ready:
            if(num == "0") {
                return num
            }
            firstNumber = num
            condition = .firstNumberEnter
            return firstNumber
        case .equalResult:
            _ = ac()
            return insertNumber(num: num)
        }
    }
    
    func insertKomma() -> String {
        switch condition {
        case .firstNumberEnter:
            if(firstNumber.firstIndex(of: ".") == nil && firstNumber.count < 9) {
                firstNumber += "."
            }
            return firstNumber
        case .secondNumberEnter:
            if(secondNumber.firstIndex(of: ".") == nil && secondNumber.count < 9) {
                secondNumber += "."
            }
            return secondNumber
        case .ready:
            firstNumber = "0."
            condition = .firstNumberEnter
            return firstNumber
        case .equalResult:
            _ = ac()
            return insertKomma()
        }
    }
    
    func unary() -> String {
        switch condition {
        case .firstNumberEnter:
            if(firstNumber.prefix(1) != "-"){
                if(firstNumber != "0") {
                    firstNumber = "-" + firstNumber
                }
            } else {
                firstNumber = firstNumber.replacingOccurrences(of: "-", with: "")
            }
            return firstNumber
        case .secondNumberEnter:
            if(secondNumber.prefix(1) != "-"){
                if(secondNumber != "0") {
                    secondNumber = "-" + secondNumber
                }
            } else {
                secondNumber = secondNumber.replacingOccurrences(of: "-", with: "")
            }
            return secondNumber
        case .ready:
            condition = .firstNumberEnter
            return firstNumber
        case .equalResult:
            condition = .firstNumberEnter
            secondNumber = "0"
            return unary()
        }
    }
    
    func procent() -> String {
        switch condition {
        case .firstNumberEnter:
            secondNumber = "100"
            operation = .division
            return equal()
        case .secondNumberEnter:
            firstNumber = secondNumber
            secondNumber = "100"
            operation = .division
            return equal()
        case .ready:
            return firstNumber
        case .equalResult:
            condition = .firstNumberEnter
            return procent()
        }
    }
    
    func ac() -> String {
        firstNumber = "0"
        secondNumber = "0"
        operation = CalculatorOperations.none
        condition = CalculatorConditions.ready
        return firstNumber
    }
    
    func operate(type: CalculatorOperations) -> String {
        operation = type
        switch condition {
        case .firstNumberEnter:
            condition = .secondNumberEnter
            return firstNumber
        case .secondNumberEnter:
            let result = equal()
            condition = .secondNumberEnter
            return result
        case .ready:
            return firstNumber
        case .equalResult:
            condition = .secondNumberEnter
            secondNumber = "0"
            return firstNumber
        }
    }
    
    func equal() -> String {
        guard let firstNumDouble = Double(firstNumber) else {
            return "Ошибка"
        }
        guard let secondNumDouble = Double(secondNumber) else {
            return "Ошибка"
        }
        switch operation {
        case .none:
            return firstNumber
        case .multiplication:
            firstNumber = "\(firstNumDouble * secondNumDouble)"
            condition = .equalResult
        case .addition:
            firstNumber = "\(firstNumDouble + secondNumDouble)"
            condition = .equalResult
        case .division:
            firstNumber = "\(firstNumDouble / secondNumDouble)"
            condition = .equalResult
        case .subtraction:
            firstNumber = "\(firstNumDouble - secondNumDouble)"
            condition = .equalResult
        }
        if(firstNumber == "0.0") {
            firstNumber = "0"
        }
        return firstNumber
    }
}
