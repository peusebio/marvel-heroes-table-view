//
//  Data.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 12/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct HeroResponseData: Decodable {
    let total: Int
    let offset: Int
    let results: [Hero]
}

struct HeroArtworkResponseData: Decodable {
    let count: Int?
    let results: [HeroArtwork]
}
