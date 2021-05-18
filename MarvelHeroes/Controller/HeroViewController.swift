//
//  HeroViewController.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 13/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class HeroViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private var hero: Hero
    
    private var heroView: HeroView
    private let delegate: HeroViewControllerDelegate
    private let heroArtworkViewController: HeroArtworkViewController
    
    let favorite: Bool
    
    init(hero: Hero, delegate: HeroViewControllerDelegate, favorite: Bool, nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        self.favorite = favorite
        self.delegate = delegate
        self.hero = hero
        
        heroView = HeroView()
        heroArtworkViewController = HeroArtworkViewController(hero: hero, nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.title = hero.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroView.configure(hero: hero)
        view.addSubview(heroView)
        addFavoriteButton()
        
        //adds a child VC that will containt all Artwork info
        heroView.configureArtworkView(view: heroArtworkViewController.view)
        addChild(heroArtworkViewController)
        heroArtworkViewController.didMove(toParent: self)
    }
    
    func addFavoriteButton(){
        if favorite {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFromFavorites))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavorites))
        }
    }
    
    @objc func addToFavorites(){
        delegate.addToFavorites(id: hero.id)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFromFavorites))
    }
    
    @objc func removeFromFavorites(){
        delegate.removeFromFavorites(id: hero.id)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavorites))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //heroView.heroImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
