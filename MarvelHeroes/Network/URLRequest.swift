//
//  URLRequest.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 29/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

extension URLRequest {
    func encode(with parameters: [String : String]?) -> URLRequest {
        guard let parameters = parameters else {
            return self
        }
        
        var encodedURLRequest = self
        
        if let url = self.url,
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            var newUrlComponents = urlComponents
            let queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            newUrlComponents.queryItems = queryItems
            encodedURLRequest.url = newUrlComponents.url
            return encodedURLRequest
        } else {
            return self
        }
    }
}
