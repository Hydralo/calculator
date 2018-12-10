//
//  ViewController.swift
//  Calculator
//
//  Created by Рабочий on 01/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var keyboardContainerLeadingLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var keyboardContainerTrailingLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var label: UILabel!
    
    private var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter(delegate: self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        roundButtons()
    }
    
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
    
    @IBAction func buttonClick(_ sender: UIButton) {
        updateLable(text: presenter.buttonClick(tag: sender.tag))
    }
    
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
        if(text != "0.0" && text.suffix(2) == ".0") {
            finalText = String(text.prefix(text.count-2))
        }
        label.text = finalText.replacingOccurrences(of: ".", with: ",")
    }
    
    
    //попробовать сделать еще одно view внутри subview , сделать нужные отступы и вертикал центр, и аспект ратио 4:5 тогда будут квадраты выходить, у квадратов убрать отсупы слева и справа
    //или у текущей вьюхи сделать отсупы, и квадарты убрать отсутпы
    //калькулятор готовый
    // состояния калькулятора енум, ready, 1 число, 2 числа , и переходы между состояниями
    //спроектировать калькулятор по ООП

}

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
