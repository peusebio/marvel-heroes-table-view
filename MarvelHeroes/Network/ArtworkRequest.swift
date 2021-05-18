//
//  ComicRequest.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 14/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct ArtworkRequest {
    let url: String
    
    static func with(url: String) -> ArtworkRequest{
        return ArtworkRequest(url: url)
    }
}
