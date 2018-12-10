//
//  Presenter.swift
//  Calculator
//
//  Created by Рабочий on 06/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

class Presenter {
    private var interactor: Interactor!
    weak var delegate: PresenterDelegate?
    
    init(delegate: PresenterDelegate) {
        interactor = Interactor(delegate: self)
        self.delegate = delegate
    }
    
    func buttonClick(tag: Int) -> String {
        return interactor.buttonClick(tag: tag)
    }
}

extension Presenter: InteractorDelegate {
    func cancelHighlightButtons() {
        delegate?.cancelHighlightButtons()
    }
    
    func highlightButton(tag: Int) {
        delegate?.highlightButton(tag: tag)
    }
}
