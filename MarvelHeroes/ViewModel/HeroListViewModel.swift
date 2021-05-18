//
//  HeroesViewModel.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 04/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation


protocol HeroListViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
    func addThumbnailToCell(cellRowIndex: Int, thumbnailData: Data)
}

final class HeroListViewModel {
    private weak var delegate: HeroListViewModelDelegate?
    
    var searchFor: String?
    
    var heroes: [Hero] = []
    var favorites: [Int] = []
    var heroThumbnailsData: [Int : Data] = [:]
    
    private var limit = 20
    var offset = 0
    var totalHeroes = 0
    
    private var isFetchInProgress = false
    
    let client = MarvelClient()
    let request: HeroListRequest
    
    let favoritesFileName = "favorites"
    let favoritesFileExtension = "json"
    
    init(request: HeroListRequest, delegate: HeroListViewModelDelegate){
        self.request = request
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return totalHeroes
    }
    
    var currentCount: Int {
        return heroes.count
    }
    
    func hero(at index: Int) -> Hero {
        return heroes[index]
    }
    
    func fetchCharacters(){
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        client.fetchHeroes(with: request, offset: self.offset, searchFor: searchFor){ [weak self] in
            let retrievedData = $0.data
            
            self?.offset += retrievedData.results.count
            self?.isFetchInProgress = false
            
            self?.totalHeroes = retrievedData.total
            self?.heroes.append(contentsOf: retrievedData.results)
            
            if retrievedData.offset > 0 {
                let indexPathsToReload = self?.calculateIndexPathsToReload(from: retrievedData.results)
                self?.delegate?.onFetchCompleted(with: indexPathsToReload)
            } else {
                self?.delegate?.onFetchCompleted(with: .none)
            }
        }
        //self.loadHeroThumbnails()
    }
    
    func loadHeroThumbnail(heroIndex: Int) {
//        let startIndex = heroes.count-offset
//        let endIndex = heroes.count

        DispatchQueue.global().async { [weak self] in
            //for i in startIndex..<endIndex {
                //self.heroThumbnailsData.append(nil)
                let hero = self?.heroes[heroIndex]
                
                let urlAsString = "\(hero!.thumbnail.path).\(hero!.thumbnail.extension)"
                let url = URL(string: urlAsString)! as URL
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        let heroId = self?.hero(at: heroIndex).id
                        self?.heroThumbnailsData[heroId!] = imageData
                        self?.delegate?.addThumbnailToCell(cellRowIndex: heroIndex, thumbnailData: imageData)
                    }
                }
            //}
        }
    }
    
    func saveFavorites(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("\(favoritesFileName).\(favoritesFileExtension)")
            
            let encoder = JSONEncoder()
            
            do {
                let jsonData = try encoder.encode(favorites)
                try jsonData.write(to: fileURL)
            }
            catch {
                print("Couldn't save your favorites to file!")
            }
        }
    }
    
    func loadFavorites() {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(favoritesFileName).\(favoritesFileExtension)") {
            do {
                let jsonData = try Data(contentsOf: url)
                favorites = try JSONSerialization.jsonObject(with: jsonData) as! [Int]
            }
            catch {
                print("Couldn't load your favorites from file!")
            }
        }
    }
    
    func isFavorite(heroId: Int) -> Bool {
        return favorites.contains(heroId)
    }
    
    private func calculateIndexPathsToReload(from newHeroes: [Hero]) -> [IndexPath] {
        let startIndex = heroes.count - newHeroes.count
        let endIndex = startIndex + newHeroes.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
