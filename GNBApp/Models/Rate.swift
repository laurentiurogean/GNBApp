//
//  Rate.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

struct Rate: Decodable, Hashable {
    let from: Currency
    let to: Currency
    let rate: Double
    
    private enum CodingKeys: String, CodingKey {
        case from
        case to
        case rate
    }
}

extension Rate {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let fromString = try values.decode(String.self, forKey: .from)
        from = Currency(rawValue: fromString)!
        
        let toString = try values.decode(String.self, forKey: .to)
        to = Currency(rawValue: toString)!
        
        let rateString = try values.decode(String.self, forKey: .rate)
        rate = Double(rateString) ?? 0
    }
}
