//
//  ButtonController.swift
//  Calculator
//
//  Created by Рабочий on 02/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

class ButtonController {
    var calculator = Calculator()
    private var inputHandler = InputHandler()
    
    init() {
    }
    
    func operate(tag: Int) -> String {
        guard let button = ButtonDatabase.buttons.first(where: {$0.tag == tag}) else {
            return ""
        }
        switch button.type {
        case .num:
            guard let num = button.num else {
                return ""
            }
            _ = inputHandler.digitAppend(num)
            return calculator.insertNumber(num: num)
        case .komma:
            _ = inputHandler.dotAppend()
            return calculator.insertKomma()
        case .ac:
            return calculator.ac()
        case .addition:
            return calculator.operate(type: .addition)
        case .subtraction:
            return calculator.operate(type: .subtraction)
        case .multiplication:
            return calculator.operate(type: .multiplication)
        case .division:
            return calculator.operate(type: .division)
        case .equal:
            return calculator.equal()
        case .unary:
            return calculator.unary()
        case .procent:
            return calculator.procent()
        }
    }
}

extension ButtonController {
    func currentCalculatorState() -> (CalculatorConditions, CalculatorOperations) {
        return calculator.currentStatusReturn()
    }
}
