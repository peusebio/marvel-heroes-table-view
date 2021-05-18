//
//  MarvelApiClient.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 16/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

class MarvelClient {
    
    private lazy var baseURL: URL = {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }()
    
    func fetchHeroes(with request: HeroListRequest, offset: Int, searchFor: String?, completion: @escaping (HeroResponse) -> ()){
        let session = URLSession.shared
        
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        var parameters = ["apikey" : "ab5e2b9926f6e2a161ceb7bd813b0370", "offset" : "\(offset)"].merging(request.parameters, uniquingKeysWith: +)
        if let searchFor = searchFor {
            parameters = parameters.merging(["nameStartsWith" : searchFor], uniquingKeysWith: +)
        }
        var encodedUrlRequest = urlRequest.encode(with: parameters)
        
        encodedUrlRequest.httpMethod = "GET"
        encodedUrlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        encodedUrlRequest.setValue("https://developer.marvel.com/docs", forHTTPHeaderField: "Referer")
        
        let task = session.dataTask(with: encodedUrlRequest, completionHandler: { data, response, error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let serverResponse = try decoder.decode(HeroResponse.self, from: data)
                    completion(serverResponse)
                } catch let error {
                    print("ERROR: \(error)")
                }
            }
        })
        task.resume()
    }
    
    func fetchHeroArtwork(heroId: String, artwortType: String, limit: Int, completion: @escaping (HeroArtworkResponse) -> ()){
        let session = URLSession.shared
        let url = URL(string: "\(baseURL)/characters/\(heroId)/\(artwortType)")!
        
        let urlRequest = URLRequest(url:url)
        let parameters = ["limit":"\(limit)", "apikey" : "ab5e2b9926f6e2a161ceb7bd813b0370"]
        var encodedUrlRequest = urlRequest.encode(with: parameters)
        
        encodedUrlRequest.httpMethod = "GET"
        encodedUrlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        encodedUrlRequest.setValue("https://developer.marvel.com/docs", forHTTPHeaderField: "Referer")
        
        let task = session.dataTask(with: encodedUrlRequest, completionHandler: { data, response, error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let serverResponse = try decoder.decode(HeroArtworkResponse.self, from: data)
                    completion(serverResponse)
                } catch let error {
                    print("ERROR WAS: \(error)\n RESPONSE WAS: \(String(describing: response))\n RESPONSE BODY WAS: \(data)")
                }
            }
        })
        task.resume()
    }
}
