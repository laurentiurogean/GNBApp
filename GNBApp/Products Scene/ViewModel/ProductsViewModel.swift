//
//  ProductsViewModel.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

class ProductsViewModel {
    var transactions: [Transaction]?
    var rates: Set<Rate>?
    var products: [String]?
    
    private let networking = Networking()
    
    func getTransactions(completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: .transactions, type: Transaction.self) { [weak self] (response) in
            self?.transactions = response
            self?.setupProducts(response)
            completion?()
        }
    }
    
    func setupProducts(_ transactions: [Transaction]) {
        var productsArray = [String]()
        for transaction in transactions {
            if !productsArray.contains(transaction.sku) {
                productsArray.append(transaction.sku)
            }
        }
        self.products = productsArray
    }
    
    func getRates() {
        networking.performNetworkTask(endpoint: .rates, type: Rate.self) { [weak self] (response) in
            self?.rates = Set(response)
            self?.completeMissingRates()
        }
    }
    
    func completeMissingRates() {
        guard let rates = rates else { return }
        
        let currenciesArray: [Currency] = Currency.allCases
        
        for currency in currenciesArray {
            
            // See in what it can be converted
            let currenciesToConvertInto = currenciesArray.filter { $0 != currency }
            
            for secondCurrency in currenciesToConvertInto {

                // If the set doesn't already have the rate
                if !(rates.contains(where: { $0.from == currency && $0.to == secondCurrency })) {
                    
                    // Get all the rates where we have currency as TO
                    let ratesToUse = rates.filter { ($0.from != currency && $0.from != secondCurrency) && $0.to == currency }
                    
                    // Get the other rates and keep only those where we have the secondCurrency as TO
                    let substractedRates = rates.subtracting(ratesToUse).filter { $0.to == secondCurrency }
                    
                    // At least one element from the substracted rates should have the same currency
                    // as FROM like one element from ratesToUse
                    guard let complementaryRate = substractedRates.first else { return }
                    
                    ratesToUse.forEach {
                        if $0.from == complementaryRate.from {
                            calculateRate(from: [$0, complementaryRate])
                        }
                    }

                }
            }
        }
    }
    
    /// Calculates a rate given 2 rates including the same currency
    func calculateRate(from rates: [Rate]) {
        guard let a = rates.first, let b = rates.last else { return }
        let newRate = Rate(from: a.to, to: b.to, rate: (b.rate/a.rate).truncateDigitsAfterDecimal(2))
        let reverseRate = Rate(from: b.to, to: a.to, rate: (a.rate/b.rate).truncateDigitsAfterDecimal(2))
        print(newRate)
        print(reverseRate)
        
        self.rates?.insert(newRate)
        self.rates?.insert(reverseRate)
    }
}
