//
//  LabelController.swift
//  Calculator
//
//  Created by Рабочий on 02/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

class LabelController {
    
    static func charactersCountWithKomma(text: String) -> Int {
        var charactersCount = text.count
        if(text.firstIndex(of: ",") != nil) {
            charactersCount -= 1
        }
        return charactersCount
    }
}
