//
//  ViewController.swift
//  Calculator
//
//  Created by Рабочий on 01/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var keyboardContainerLeadingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var keyboardContainerTrailingLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    
    private var presenter: Presenter!
    
    // MARK: - IBActions
    
    @IBAction func buttonClick(_ sender: UIButton) {
        updateLable(text: presenter.buttonClick(tag: sender.tag))
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
            button.backgroundColor = UIColor(red: CGFloat((0xe12d30 & 0xFF0000) >> 16) / 255.0,
                                             green: CGFloat((0xe12d30 & 0x00FF00) >> 8) / 255.0,
                                             blue: CGFloat(0xe12d30 & 0x0000FF) / 255.0,
                                             alpha: CGFloat(1.0))
            
        }
    }
}

// MARK: - Lifecycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Нахера это здесь? должно при инициализации создаваться
        presenter = Presenter(delegate: self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        roundButtons()
    }
}

// MARK: Buttons hightlighting. Implementation of PresenterDelegate protocol

extension ViewController: PresenterDelegate {
    func highlightButton(tag: Int) {
        guard let button = view.viewWithTag(tag) as? UIButton else {
            return
        }
        button.backgroundColor = UIColor(red: CGFloat((0xb10003 & 0xFF0000) >> 16) / 255.0,
                                         green: CGFloat((0xb10003 & 0x00FF00) >> 8) / 255.0,
                                         blue: CGFloat(0xb10003 & 0x0000FF) / 255.0,
                                         alpha: CGFloat(1.0))
    }
    func cancelHighlightButtons() {
        for i in 1...19 {
            guard let button = view.viewWithTag(i) as? UIButton else {
                continue
            }
            button.backgroundColor = UIColor(red: CGFloat((0xe12d30 & 0xFF0000) >> 16) / 255.0,
                                             green: CGFloat((0xe12d30 & 0x00FF00) >> 8) / 255.0,
                                             blue: CGFloat(0xe12d30 & 0x0000FF) / 255.0,
                                             alpha: CGFloat(1.0))
        }
    }
    
}

