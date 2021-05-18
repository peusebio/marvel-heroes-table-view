//
//  HeroView.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 13/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class HeroView: UIView {
    
    private let mainScreen = UIScreen.main
    
    init (){
        super.init(frame: mainScreen.bounds)
        
        backgroundColor = Colors.interfaceStyleHighlightColor()
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let heroImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = ContentMode.scaleAspectFit
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let heroDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    func configure(hero: Hero){
        
        if hero.description.isEmpty {
            heroDescriptionLabel.text = "No description available for this hero 🤷"
        } else {
            heroDescriptionLabel.text = hero.description
        }
        
        let urlAsString = "\(hero.thumbnail.path).\(hero.thumbnail.extension)"
        let url = URL(string: urlAsString)! as URL
        
        DispatchQueue.global().async { [weak self] in
            
            if let imageData = try? Data(contentsOf: url){
                
                DispatchQueue.main.async {
                    
                    self?.heroImageView.image = UIImage(data: imageData as Data)
                    //                    if we want the text to wrap around the image we can use the
                    //                    if let frame = self?.heroImageView.frame{
                    //                        let imageFrame = UIBezierPath(rect: frame)
                    //                        self?.heroDescriptionTextView.textContainer.exclusionPaths = [imageFrame]
                    //                    }
                }
            }
        }
    }
    
    func configureArtworkView(view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.interfaceStyleHighlightColor()
        addSubview(view)
        
        addConstraint(NSLayoutConstraint(item: view, attribute: .topMargin, relatedBy: .equal, toItem: heroDescriptionLabel, attribute: .bottomMargin, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: view, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
    }
    
    func setupViews(){
        /*This makes the text wrap around the image
         addSubview(heroDescriptionTextView)
         heroDescriptionTextView.addSubview(heroImageView)
         
         addConstraint(NSLayoutConstraint(item: heroDescriptionTextView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 10))
         addConstraint(NSLayoutConstraint(item: heroDescriptionTextView, attribute: .leftMargin, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1, constant: 0))
         addConstraint(NSLayoutConstraint(item: heroDescriptionTextView, attribute: .rightMargin, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1, constant: -10))
         addConstraint(NSLayoutConstraint(item: heroDescriptionTextView, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0))
         
         addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/3, constant: 1))
         addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/3, constant: 1))
         addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .topMargin, relatedBy: .equal, toItem: heroDescriptionTextView, attribute: .topMargin, multiplier: 1, constant: 10))
         addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .leftMargin, relatedBy: .equal, toItem: heroDescriptionTextView, attribute: .leftMargin, multiplier: 1, constant: 10))
         */
        
        addSubview(heroImageView)
        addSubview(heroDescriptionLabel)
        
        addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1/2, constant: 1))
        addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1/2, constant: 1))
        addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 30))
        addConstraint(NSLayoutConstraint(item: heroImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: heroDescriptionLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 5/6, constant: 1))
//        addConstraint(NSLayoutConstraint(item: heroDescriptionLabel, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 1/6, constant: 1))
        addConstraint(NSLayoutConstraint(item: heroDescriptionLabel, attribute: .topMargin, relatedBy: .equal, toItem: heroImageView, attribute: .bottomMargin, multiplier: 1, constant: 30))
        addConstraint(NSLayoutConstraint(item: heroDescriptionLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
}
