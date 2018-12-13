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
    
    func buttonClick(tag: Int) -> String {
        return interactor.buttonClick(tag: tag)
    }
}

// MARK: - Private functions

extension Presenter {
    func highlightButton(binaryOperation: BinaryArithmeticOperation) {
        let calculatorState = interactor.currentCalculatorState()
        guard let view = viewController else {
            return
        }
        if calculatorState.0 != .equalResult {
            if calculatorState.1 == .none || binaryOperation == .equal{
                view.cancelHighlightButtons()
            } else {
                view.highlightButton(binaryOperationType: binaryOperation)
            }
        }
    }
    
    func highlightingCheck()  {
        let calculatorState = interactor.currentCalculatorState()
        guard let view = viewController else {
            return
        }
        if calculatorState.0 != .equalResult {
            if calculatorState.1 == .none {
                view.cancelHighlightButtons()
            } else {
                switch calculatorState.1 {
                case .addition:
                     view.highlightButton(binaryOperationType: .addition)
                case .division:
                    view.highlightButton(binaryOperationType: .division)
                case .multiplication:
                    view.highlightButton(binaryOperationType: .multiplication)
                case .subtraction:
                    view.highlightButton(binaryOperationType: .subtraction)
                case .none:
                     view.cancelHighlightButtons()
                }
               
            }
        }
    }
    
    func cancelHightlightingButtons() {
        viewController?.cancelHighlightButtons()
    }
}
