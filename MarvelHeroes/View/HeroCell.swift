//
//  HeroCell.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeroCell: BaseCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure(with: .none, isFavorite: false)
    }
    
    let thumbnailImageView: UIImageView = {
        let thumbnailImageView = UIImageView()
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = ContentMode.scaleAspectFill
        return thumbnailImageView
    }()
    
    let thumbnailLoadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.color = Colors.marvelRed
        return indicatorView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        indicatorView.color = Colors.marvelRed
        return indicatorView
    }()
    
    let cellBackgroundView: UIView = {
        let view = UIView(frame: CGRect())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = Colors.heroCellBackgroundColor
        return view
    }()
    
    let favoriteIndicatorImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setupViews(){
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(indicatorView)
        
        addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: cellBackgroundView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .centerY, relatedBy: .equal, toItem: cellBackgroundView, attribute: .centerY, multiplier: 1, constant: 0))
        cellBackgroundView.addSubview(thumbnailLoadingIndicatorView)
        cellBackgroundView.addSubview(thumbnailImageView)
        cellBackgroundView.addSubview(titleLabel)
        cellBackgroundView.addSubview(favoriteIndicatorImageView)
        
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cellBackgroundView, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -5))
        
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .leadingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .leadingMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .centerY, relatedBy: .equal, toItem: cellBackgroundView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .width, relatedBy: .equal, toItem: cellBackgroundView, attribute: .height, multiplier: 0.85, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumbnailImageView, attribute: .height, relatedBy: .equal, toItem: cellBackgroundView, attribute: .height, multiplier: 0.85, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .leadingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .leadingMargin, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: cellBackgroundView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .width, relatedBy: .equal, toItem: cellBackgroundView, attribute: .height, multiplier: 0.85, constant: 0))
        addConstraint(NSLayoutConstraint(item: thumbnailLoadingIndicatorView, attribute: .height, relatedBy: .equal, toItem: cellBackgroundView, attribute: .height, multiplier: 0.85, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: thumbnailImageView, attribute: .trailingMargin, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: cellBackgroundView, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -12))
        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .topMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .topMargin, multiplier: 1, constant: 12))
        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .width, relatedBy: .equal, toItem: cellBackgroundView, attribute: .height, multiplier: 0.15, constant: 1))
        addConstraint(NSLayoutConstraint(item: favoriteIndicatorImageView, attribute: .height, relatedBy: .equal, toItem: cellBackgroundView, attribute: .height, multiplier: 0.15, constant: 1))
    }
    
    func configure(with hero: Hero?, isFavorite: Bool) {
        if let hero = hero {
            thumbnailLoadingIndicatorView.startAnimating()
            indicatorView.stopAnimating()
            titleLabel.isHidden = false
            thumbnailImageView.isHidden = false
            titleLabel.text = hero.name
            if isFavorite {
                favoriteIndicatorImageView.isHidden = false
                favoriteIndicatorImageView.image = UIImage(systemName: "star.fill")
                favoriteIndicatorImageView.tintColor = UIColor.red
            } else {
                favoriteIndicatorImageView.isHidden = true
            }
//            if let thumbnail = hero.heroThumbnail {
//                thumbnailImageView.image = UIImage(data: thumbnail as Data)
//            }
            
//            if let image = hero.heroThumbnail {
//                thumbnailImageView.image = UIImage(data: image as Data)
//            } else {
//                let urlAsString = "\(hero.thumbnail.path).\(hero.thumbnail.extension)"
//                //print(urlAsString)
//                let url = URL(string: urlAsString)! as URL
//
//                DispatchQueue.global().async { [weak self] in
//                    if let imageData = try? Data(contentsOf: url){
//                        DispatchQueue.main.async {
//                            self?.thumbnailImageView.image = UIImage(data: imageData as Data)
//                            //                        self?.titleLabel.alpha = 1
//                            //                        self?.indicatorView.alpha = 0
//                            //                        self?.titleLabel.text = hero.name
//                        }
//                    }
//                }
//            }
        } else {
            titleLabel.isHidden = true
            thumbnailImageView.image = nil
            thumbnailImageView.isHidden = true
            indicatorView.startAnimating()
        }
    }
    
    func addThumbnail(thumbnailData: Data) {
        thumbnailLoadingIndicatorView.stopAnimating()
        thumbnailImageView.image = UIImage(data: thumbnailData as Data)
    }
}
