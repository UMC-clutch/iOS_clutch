//
//  Ext + UIViewController.swift
//  clutch_iOS
//
//  Created by Dongwan Ryoo on 2023/08/23.
//

import UIKit

extension UIViewController {
    func decimalPoint(_ txt:Int) -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        
        let decimalPrice: String = numberFormatter.string(for: txt)!
        return decimalPrice
    }
    
    func removedecimalPoint(_ formattedNumber: String) -> Int {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        
        let formattedString = formattedNumber.replacingOccurrences(of: ",", with: "")
        let intValue = numberFormatter.number(from: formattedString)?.intValue
            
        return intValue ?? 0
    
    }
}
