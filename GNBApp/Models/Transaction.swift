//
//  Transaction.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

enum Currency: String, CaseIterable, Decodable {
    case EUR = "EUR"
    case CAD = "CAD"
    case USD = "USD"
    case AUD = "AUD"
}

struct Transaction: Decodable {
    let sku: String
    let amount: Double
    let currency: Currency
    
    private enum CodingKeys: String, CodingKey {
        case sku
        case amount
        case currency
    }
}

extension Transaction {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sku = try values.decode(String.self, forKey: .sku)
        
        let amountString = try values.decode(String.self, forKey: .amount)
        amount = Double(amountString) ?? 0
        
        let currencyString = try values.decode(String.self, forKey: .currency)
        currency = Currency(rawValue: currencyString)!
    }
}
