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
    @IBOutlet weak var containerWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    
    private var presenter: Presenter!

    // MARK: - IBActions
    
    @IBAction func buttonClick(_ sender: UIButton) {
        updateLable(text: presenter.buttonClick(tag: sender.tag))
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Нахера это здесь? должно при инициализации создаваться
        presenter = Presenter(delegate: self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let safeAreaWidth = super.view.safeAreaLayoutGuide.layoutFrame.width
        containerWidthLayoutConstraint.constant = safeAreaWidth - 14
        containerHeightLayoutConstraint.constant = containerWidthLayoutConstraint.constant * 1.2
        view.layoutIfNeeded()
        roundButtons()
    }
    
    // MARK: - Functions
    
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
    
// S - слишком много задач у метода
    func updateLable(text: String) {
        let charactersCount = LabelController.charactersCountWithKomma(text: text)
        switch charactersCount {
        case 6:
            label.font = label.font.withSize(68)
        case 7:
            label.font = label.font.withSize(64)
        case 8:
            label.font = label.font.withSize(60)
        case _ where charactersCount >= 9:
            label.font = label.font.withSize(56)
        default:
            label.font = label.font.withSize(72)
        }
        var finalText = text
//        if(text != "0.0" && text.suffix(2) == ".0") {
//            finalText = String(text.prefix(text.count-2))
//        }
        label.text = finalText.replacingOccurrences(of: ".", with: ",")
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
