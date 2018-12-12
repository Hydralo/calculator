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
    weak var viewController: ViewController?
    
    init(viewController: ViewController) {
        interactor = Interactor()
        self.viewController = viewController
    }
    
    func buttonClick(tag: Int) -> String {
        let dashboard = interactor.buttonClick(tag: tag)
        hightlighter(buttonTag: tag)
        return dashboard
    }
}

// MARK: - Private functions

extension Presenter {
    func hightlighter(buttonTag: Int) {
        let calculatorState = interactor.currentCalculatorState()
        guard let view = viewController else {
            return
        }
        if calculatorState.0 == .firstNumberEnter || calculatorState.0 == .secondNumberEnter {
            switch calculatorState.1 {
            case .addition:
                view.highlightButton(tag: 16)
            case .subtraction:
                view.highlightButton(tag: 12)
            case .division:
                view.highlightButton(tag: 4)
            case .multiplication:
                view.highlightButton(tag: 8)
            case .none:
                view.cancelHighlightButtons()
            }
        }
    }
}
