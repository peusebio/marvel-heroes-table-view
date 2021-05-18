//
//  HeroViewModel.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 14/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

class HeroArtworkViewModel {
    
    var artworkCellsViewModels: [[HeroArtworkCellViewModel?]] = Array(repeating: Array(repeating:nil, count: 3), count: 4)
    private weak var delegate: HeroListViewModelDelegate?
    
    let maxArtworkAmount = 3
    let client = MarvelClient()
    
    let hero: Hero
    
    init(hero: Hero){
        self.hero = hero
    }
    
    func fetchHeroArtwork(heroId: String, completion: @escaping ([[HeroArtwork]]) -> ()){
        let artworkTypes = ["comics", "events", "stories", "series"]
        var artwork = [[HeroArtwork]]()
        var heroComics = [HeroArtwork]()
        var heroEvents = [HeroArtwork]()
        var heroStories = [HeroArtwork]()
        var heroSeries = [HeroArtwork]()
        
        let group = DispatchGroup()
        artworkTypes.forEach { artworkType in
            group.enter()
            self.client.fetchHeroArtwork(heroId: heroId, artwortType: artworkType, limit: maxArtworkAmount) { [] in
                switch artworkType {
                case "comics":
                    heroComics = $0.data.results
                    group.leave()
                case "events":
                    heroEvents = $0.data.results
                    group.leave()
                case "stories":
                    heroStories = $0.data.results
                    group.leave()
                case "series":
                    heroSeries = $0.data.results
                    group.leave()
                default:
                    print ("\(artworkType) is not a valid option")
                    group.leave()
                }
            }
        }
        group.wait()
        artwork.append(heroComics)
        artwork.append(heroEvents)
        artwork.append(heroStories)
        artwork.append(heroSeries)
        completion(artwork)
    }
}
