//
//  ProductDetailViewModel.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/17/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

class ProductDetailViewModel {
    var product: String
    var transactions: [Transaction]
    var rates: Set<Rate>
    
    init(product: String, transactions: [Transaction], rates: Set<Rate>) {
        self.product = product
        self.transactions = transactions.filter { $0.sku == product }
        self.rates = rates
    }
    
    func getSumOfTransactions(completion: @escaping (Int) -> Void) {
        var sum = 0
        transactions.forEach {
            if $0.currency != .EUR {
                let amount = convert(amount: $0.amount, from: $0.currency, to: .EUR)
                sum += lrint(amount.truncateDigitsAfterDecimal(2))
            }
        }
        completion(sum)
    }
    
    func convert(amount: Double, from currency: Currency, to: Currency) -> Double {
        guard let rate = (rates.filter { $0.from == currency && $0.to == to }).first else { return 0 }
        return amount * rate.rate
    }
}
