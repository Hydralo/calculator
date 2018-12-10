//
//  ButtonDatabase.swift
//  Calculator
//
//  Created by Рабочий on 06/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

class ButtonDatabase {
    static var buttons = [Button(tag: 1, type: ButtonType.ac),
                          Button(tag: 2, type: ButtonType.unary),
                          Button(tag: 3, type: ButtonType.procent),
                          Button(tag: 4, type: ButtonType.division),
                          Button(tag: 5, num: "7"),
                          Button(tag: 6, num: "8"),
                          Button(tag: 7, num: "9"),
                          Button(tag: 8, type: ButtonType.multiplication),
                          Button(tag: 9, num: "4"),
                          Button(tag: 10, num: "5"),
                          Button(tag: 11, num: "6"),
                          Button(tag: 12, type: ButtonType.subtraction),
                          Button(tag: 13, num: "1"),
                          Button(tag: 14, num: "2"),
                          Button(tag: 15, num: "3"),
                          Button(tag: 16, type: ButtonType.addition),
                          Button(tag: 17, num: "0"),
                          Button(tag: 18, type: ButtonType.komma),
                          Button(tag: 19, type: ButtonType.equal)]
}
