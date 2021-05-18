//
//  Colors.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 12/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    static let marvelRed = UIColor(red: 234/255, green: 34/255, blue: 46/255, alpha: 1)
    
    static let heroCellBackgroundColor: UIColor = {
        if userInterfaceStyle() == .dark {
            return UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        }
        return UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }()
    
    static let artworkCellBackgroundColor: UIColor = {
           if userInterfaceStyle() == .dark {
               return UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
           }
           return UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }()
    
    private static func userInterfaceStyle() -> UIUserInterfaceStyle {
        UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    static func interfaceStyleHighlightColor() -> UIColor {
        userInterfaceStyle() == .dark ? UIColor.black : UIColor.white
    }
}
