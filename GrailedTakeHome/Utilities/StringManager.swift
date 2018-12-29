//
//  StringManager.swift
//  GrailedTakeHome
//
//  Created by Sam on 12/18/18.
//  Copyright © 2018 Samuel Huang. All rights reserved.
//
//  For formatting values into strings and vv

import Foundation

class StringManager {

    class func centsValueToString(_ cents: Int) -> String {
        let priceString = String(cents)
        var dollarValueString = String(priceString.prefix(priceString.count-2))
        if dollarValueString.count == 0 { dollarValueString = "0" }
        if cents == 0 {
            return "$0.00"
        } else {
            return "$\(dollarValueString).\(String(priceString.suffix(2)))"
        }
    }
}
