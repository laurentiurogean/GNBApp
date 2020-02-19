//
//  DoubleExtension.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/18/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

extension Double {
    func truncateDigitsAfterDecimal(_ digits: Int) -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = digits
        numberFormatter.maximumFractionDigits = digits

        return Double(numberFormatter.string(from: NSNumber(value: self))!)!
    }
}
