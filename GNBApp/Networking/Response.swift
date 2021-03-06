//
//  Response.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Decodable>(_ type: T.Type) -> [T]? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode([T].self, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
    }
}
