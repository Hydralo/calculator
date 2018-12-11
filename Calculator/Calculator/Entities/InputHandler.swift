//
//  InputHandler.swift
//  Calculator
//
//  Created by Igor on 10/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation

struct InputHandler {
    private var dashboard = ""
    private var userIsPrinting = false
}

extension InputHandler {
    mutating func digitAppend(_ buttonLabel: String) {
        if userIsPrinting {
            if buttonLabel == "0" && dashboard == "0" {
                return
            } else {
                dashboard += "\(buttonLabel)"
            }
        } else {
            dashboard = "\(buttonLabel)"
            userIsPrinting = true
        }
        print("\(dashboard)")
    }
    
    mutating func dotAppend()  {
        if userIsPrinting && !dashboard.contains(".") {
            dashboard += "."
        } else if dashboard.contains(".") {
            return
        } else {
            dashboard = "0."
            userIsPrinting = true
        }
        print("\(dashboard)")
    }
    
    mutating func clearAll() {
        dashboard = ""
        if userIsPrinting {
            userIsPrinting = false
        }
    }
}
