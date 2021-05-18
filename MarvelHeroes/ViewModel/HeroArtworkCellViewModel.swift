//
//  HeroArtworkCellViewModel.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 11/04/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import Foundation

class HeroArtworkCellViewModel {
    
    let heroArtwork: HeroArtwork
    var shouldDisplayDescription: Bool
    
    init(heroArtwork: HeroArtwork, shouldDisplayDescription: Bool){
        self.heroArtwork = heroArtwork
        self.shouldDisplayDescription = shouldDisplayDescription
    }
    
}
