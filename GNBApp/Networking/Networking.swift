//
//  Networking.swift
//  GNBApp
//
//  Created by Laurentiu Rogean on 2/14/20.
//  Copyright © 2020 Laurentiu Rogean. All rights reserved.
//

import Foundation

struct Networking {
    func performNetworkTask<T: Decodable>(endpoint: GnbAPI,
                                        type: T.Type,
                                        completion: ((_ response: [T]) -> Void)?) {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }

        urlSession.resume()
    }
}
