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
    private var isPositive = true
}

extension InputHandler {
    mutating func digitAppend(_ buttonLabel: String) -> String {
        if userIsPrinting {
            if buttonLabel == "0" && dashboard == "0" {
                return returnDashboardWithSign()
            } else {
                dashboard += "\(buttonLabel)"
            }
        } else {
            dashboard += "\(buttonLabel)"
            userIsPrinting = true
        }
        return returnDashboardWithSign()
    }
    
    mutating func dotAppend() -> String {
        if userIsPrinting && !dashboard.contains(".") {
            dashboard += "."
        } else if dashboard.contains(".") {
            return dashboard
        } else {
            dashboard = "0."
            userIsPrinting = true
        }
        return returnDashboardWithSign()
    }
    
    mutating func minusPlus() -> String {
        isPositive = !isPositive
        return returnDashboardWithSign()
    }
    
    mutating func clearAll() {
        dashboard = ""
        isPositive = true
        if userIsPrinting {
            userIsPrinting = false
        }
    }
    
    private mutating func returnDashboardWithSign() -> String {
        if dashboard.count < 10 {
            if isPositive && userIsPrinting {
                return dashboard
            } else if isPositive && !userIsPrinting {
                return "0"
            } else if !isPositive && userIsPrinting {
                return "-" + dashboard
            } else {
                return "-0"
            }
        } else {
            dashboard.removeSubrange(dashboard.index(dashboard.startIndex, offsetBy: 9)...)
            return dashboard
        }
    }
}
