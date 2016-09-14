//
//  Int + Extension.swift
//  ZapCodeChallenge
//
//  Created by Fabio Yudi Takahara on 13/09/16.
//  Copyright © 2016 Fabio Yudi Takahara. All rights reserved.
//

import UIKit

struct Number {
    static let formatterWithSepator: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .DecimalStyle
        return formatter
    }()
}
extension IntegerType {
    
    var formatSellPrice: String {
        
        if self == 0 {
            return "R$  -"
        }
        
        return String(format: "R$ " + Number.formatterWithSepator.stringFromNumber(hashValue)!) ?? ""
    }
    
    var formatlocationPrice: String {
        
        if self == 0 {
            return ""
        }
        
        return String(format: "R$ " + Number.formatterWithSepator.stringFromNumber(hashValue)!) ?? ""
    }
}