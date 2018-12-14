//
//  Presenter.swift
//  Calculator
//
//  Created by Рабочий on 06/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

// MARK: - Constants & initialization

class Presenter {
    private var interactor: Interactor!
    private weak var viewController: ViewController?
    
    init(viewController: ViewController) {
        interactor = Interactor()
        self.viewController = viewController
    }
}

// MARK: - Functions

extension Presenter {
    func buttonClick(tag: Int) -> String {
        let dashboardValue = interactor.buttonClick(tag: tag)
        let calculatorState = interactor.getState()
        let state = calculatorState.0
        let operation = calculatorState.1
        viewController?.updateCurrentStatusLabels(state: state, operation: operation)
        highlighting(state: state, operation: operation)
        return dashboardValue
    }
}

// MARK: - Private functions

private extension Presenter {
    func highlighting(state: CalculatorConditions, operation: CalculatorOperations) {
        if state == .ready || state == .equalResult {
            cancelHightlightingButtons()
        } else {
            switch operation {
            case .addition:
                cancelHightlightingButtons()
                highlightButton(binaryOperation: .addition)
            case .subtraction:
                cancelHightlightingButtons()
                highlightButton(binaryOperation: .subtraction)
            case .multiplication:
                cancelHightlightingButtons()
                highlightButton(binaryOperation: .multiplication)
            case .division:
                cancelHightlightingButtons()
                highlightButton(binaryOperation: .division)
            case .none:
                cancelHightlightingButtons()
            }
        }
    }
    
    
    func highlightButton(binaryOperation: BinaryArithmeticOperation) {
        viewController?.highlightButton(buttonOperation: binaryOperation)
    }
    
    func cancelHightlightingButtons() {
        viewController!.cancelHighlightButtons()
    }
    
}
