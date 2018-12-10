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
    weak var delegate: InteractorDelegate?
    
    init(delegate: InteractorDelegate) {
        self.delegate = delegate
        buttonController = ButtonController()
        buttonController.setCallback(delegate: self)
    }
    
    func buttonClick(tag: Int) -> String {
        return buttonController.operate(tag: tag)
    }
}

extension Interactor: ButtonControllerDelegate {
    func cancelHighlightButtons() {
        delegate?.cancelHighlightButtons()
    }
    
    func highlightButton(tag: Int) {
        delegate?.highlightButton(tag: tag)
    }
}
