//
//  Response.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 16/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct HeroResponse: Decodable{
    let code: Int
    let status: String
    let data: HeroResponseData
}

struct HeroArtworkResponse: Decodable{
    let code: Int
    let status: String
    let data: HeroArtworkResponseData
}
