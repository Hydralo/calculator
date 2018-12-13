//
//  ViewController.swift
//  Calculator
//
//  Created by Рабочий on 01/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit

enum BinaryArithmeticOperation: Int {
    case addition
    case subtraction
    case multiplication
    case division
    case equal
}

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var keyboardContainerLeadingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyboardContainerTrailingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var digitButtons: [UIButton] = []
    @IBOutlet var binaryOperationButtons: [UIButton] = []
    
    @IBOutlet var allButtons: [UIButton] = []
    
    private var presenter: Presenter!
    
    // MARK: - IBActions
    
    @IBAction func buttonClick(_ sender: UIButton) {
        updateLable(text: presenter.buttonClick(tag: sender.tag))
    }
    
    
    @IBAction func digitButtonPressed(_ digitButton: UIButton) {
        guard let digit = digitButtons.index(of: digitButton) else {
            return
        }
    }
    
    @IBAction func allClearButtonPressed(_ sender: UIButton) {
        presenter.highlightingCheck()
    }
    
    @IBAction func operationButtonPressed(_ operatopnButton: UIButton) {
        guard let operationIndex = binaryOperationButtons.index(of: operatopnButton),
            let operation = BinaryArithmeticOperation(rawValue: operationIndex) else {
                return
        }
        presenter.cancelHightlightingButtons()
        presenter.highlightButton(binaryOperation: operation)
    }
    
}

// MARK: - Functions

extension ViewController {
    
    func updateLable(text: String) {
        var finalText = text
        if text != "0.0" && text.suffix(2) == ".0" {
            finalText = String(text.prefix(text.count-2))
        } else if text == "0.0" {
            finalText = "0"
        }
        label.text = finalText.replacingOccurrences(of: ".", with: ",")
    }
}

// MARK: - Private functions

extension ViewController {
    
    private func roundButtons() {
        var baseCornerRadius: CGFloat?
        
        for i in 1...19 {
            guard let button = view.viewWithTag(i) as? UIButton else {
                continue
            }
            
            if baseCornerRadius == nil {
                baseCornerRadius = button.frame.width / 2
            }
            button.layer.cornerRadius = baseCornerRadius!
            button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}

// MARK: - Lifecycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Нахера это здесь? должно при инициализации создаваться
        presenter = Presenter(viewController: self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        roundButtons()
        colorBinaryOperationButtons()
        colorDigitButtons()
    }
}

// MARK: Buttons hightlighting. Implementation of PresenterDelegate protocol

extension ViewController: PresenterDelegate {
    func highlightButton(binaryOperationType: BinaryArithmeticOperation) {
        let buttonToHightlight = binaryOperationButtons[binaryOperationType.rawValue]
        buttonToHightlight.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    }
    
    func cancelHighlightButtons() {
        for button in binaryOperationButtons {
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
}

// MARK: Buttons coloring

extension ViewController {
    func colorBinaryOperationButtons()  {
        for button in binaryOperationButtons {
            button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
    
    func colorDigitButtons()  {
        for button in digitButtons {
            button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}
