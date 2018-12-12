//
//  Interactor.swift
//  Calculator
//
//  Created by Рабочий on 06/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

class Interactor {
    var buttonController: ButtonController
    
    init() {
        buttonController = ButtonController()
    }
    
    func buttonClick(tag: Int) -> String {
        return buttonController.operate(tag: tag)
    }
    
    func currentCalculatorState() -> (CalculatorConditions, CalculatorOperations) {
        return buttonController.currentCalculatorState()
    }
}
