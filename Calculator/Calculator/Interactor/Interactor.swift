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
        let dashboardValue = buttonController.operate(tag: tag)
        return dashboardValue
    }
    
    func getState() -> (CalculatorConditions, CalculatorOperations) {
        let currentCalculatorState = buttonController.currentCalculatorState()
        let state = currentCalculatorState.0
        let operation = currentCalculatorState.1
        return (state, operation)
    }
    
}
