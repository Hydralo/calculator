//
//  ButtonController.swift
//  Calculator
//
//  Created by Рабочий on 02/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

class ButtonController {
    private var calculator: Calculator
    weak var delegate: ButtonControllerDelegate?
    
    init() {
        calculator = Calculator()
    }
    
    func setCallback(delegate: ButtonControllerDelegate) {
        self.delegate = delegate
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
            return calculator.insertNumber(num: num)
        case .komma:
            return calculator.insertKomma()
        case .ac:
            delegate?.cancelHighlightButtons()
            return calculator.ac()
        case .addition:
            delegate?.cancelHighlightButtons()
            delegate?.highlightButton(tag: button.tag)
            return calculator.operate(type: .addition)
        case .subtraction:
            delegate?.cancelHighlightButtons()
            delegate?.highlightButton(tag: button.tag)
            return calculator.operate(type: .subtraction)
        case .multiplication:
            delegate?.cancelHighlightButtons()
            delegate?.highlightButton(tag: button.tag)
            return calculator.operate(type: .multiplication)
        case .division:
            delegate?.cancelHighlightButtons()
            delegate?.highlightButton(tag: button.tag)
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
