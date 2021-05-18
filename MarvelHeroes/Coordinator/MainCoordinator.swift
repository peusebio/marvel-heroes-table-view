//
//  MainCoordinator.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/08/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        let vc = HeroTableViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showHeroDetails(hero: Hero, delegate: HeroViewControllerDelegate, favorite: Bool, nibName: String!, bundle: Bundle!){
        let vc = HeroViewController(hero: hero, delegate: delegate, favorite: favorite, nibName: nibName, bundle: bundle)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
