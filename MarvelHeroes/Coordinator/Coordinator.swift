//
//  Coordinator.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/08/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
