//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 12/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

struct Hero: Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let thumbnail: Thumbnail
    let comics: HeroComicsInfo?
    let events: HeroEventsInfo?
    let stories: HeroStoriesInfo?
    let series: HeroSeriesInfo?
    
    var favorite: Bool = false
    var heroThumbnail: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case resourceURI
        case thumbnail
        case comics
        case events
        case stories
        case series
        case favorite
        case heroThumbnail
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        modified = try container.decode(String.self, forKey: .modified)
        resourceURI = try container.decode(String.self, forKey: .resourceURI)
        thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        comics = try container.decode(HeroComicsInfo.self, forKey: .comics)
        events = try container.decode(HeroEventsInfo.self, forKey: .events)
        stories = try container.decode(HeroStoriesInfo.self, forKey: .stories)
        series = try container.decode(HeroSeriesInfo.self, forKey: .series)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite) ?? false
        //heroThumbnail = setThumbnail(thumbnail: thumbnail)
    }
    
//    func setThumbnail(thumbnail: Thumbnail) -> Data? {
//        let urlAsString = "\(thumbnail.path).\(thumbnail.extension)"
//        let url = URL(string: urlAsString)! as URL
//        
//        var imgData: Data?
//        
//        DispatchQueue.global().async {
//            if let imageData = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    imgData = imageData
//                }
//            } else {
//                imgData = .none
//            }
//        }
//        
//        return imgData
//    }
    
}
