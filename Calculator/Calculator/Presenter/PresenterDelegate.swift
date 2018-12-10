//
//  ViewControllerDelegate.swift
//  Calculator
//
//  Created by Рабочий on 08/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

protocol PresenterDelegate: class {
    func highlightButton(tag: Int)
    func cancelHighlightButtons()
}
