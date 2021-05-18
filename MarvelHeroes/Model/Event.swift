//
//  Event.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 14/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct HeroEventsInfo: Decodable {
    let available: Int
    let items: [Item]
}
