//
//  GNBAPI.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

enum GnbAPI {
    case rates
    case transactions
}

extension GnbAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "http://gnb.dev.airtouchmedia.com")!
    }

    var path: String {
        switch self {
        case .rates:
            return "/rates.json"
        case .transactions:
            return "/transactions.json"
        }
    }
}
