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
    @IBOutlet weak var dashboardLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    
    @IBOutlet var digitButtonsArray: [UIButton] = []
    @IBOutlet var binaryOperationButtonsArray: [UIButton] = []
    
    private var presenter: Presenter!
    
    // MARK: - IBActions
    
    @IBAction func buttonClick(_ sender: UIButton) {
        updateLable(text: presenter.buttonClick(tag: sender.tag))
    }
    
    @IBAction func allClearButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func operationButtonPressed(_ operatopnButton: UIButton) {
        guard let operationIndex = binaryOperationButtonsArray.index(of: operatopnButton),
            let _ = BinaryArithmeticOperation(rawValue: operationIndex) else {
                return
        }
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
        dashboardLabel.text = finalText.replacingOccurrences(of: ".", with: ",")
    }
    
    func updateCurrentStatusLabels(state: CalculatorConditions, operation: CalculatorOperations) {
        stateLabel.text = "\(state)"
        operationLabel.text = "\(operation)"
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
        }
    }
}

// MARK: - Lifecycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter(viewController: self)
        colorBinaryOperationButtons()
        colorDigitButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundButtons()
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//    }
}

// MARK: Buttons hightlighting. Implementation of PresenterDelegate protocol

extension ViewController: PresenterDelegate {
    func highlightButton(buttonOperation: BinaryArithmeticOperation) {
        let buttonToHightlight = binaryOperationButtonsArray[buttonOperation.rawValue]
        buttonToHightlight.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    }
    
    func cancelHighlightButtons() {
        for button in binaryOperationButtonsArray {
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
}

// MARK: Buttons coloring

extension ViewController {
    func colorBinaryOperationButtons()  {
        for button in binaryOperationButtonsArray {
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
    func colorDigitButtons()  {
        for button in digitButtonsArray {
            button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
}
