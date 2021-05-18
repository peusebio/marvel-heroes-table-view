//
//  HeroArtworkCell.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 04/04/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class HeroArtworkCell: BaseCell {
    
    private var titleLabelTopMarginConstraint = NSLayoutConstraint()
    private var titleLabelBottomMarginConstraint = NSLayoutConstraint()
    private var titleLabelLeadingMarginConstraint = NSLayoutConstraint()
    private var titleLabelTrailingMarginConstraint = NSLayoutConstraint()
    
    private var descriptionLabelTopMarginConstraint = NSLayoutConstraint()
    private var descriptionLabelBottomMarginConstraint = NSLayoutConstraint()
    private var descriptionLabelLeadingMarginConstraint = NSLayoutConstraint()
    private var descriptionLabelTrailingMarginConstraint = NSLayoutConstraint()
    
    private var cellBackgroundViewTopMarginConstraint = NSLayoutConstraint()
    private var cellBackgroundViewBottomMarginConstraint = NSLayoutConstraint()
    private var cellBackgroundViewLeadingMarginConstraint = NSLayoutConstraint()
    private var cellBackgroundViewTrailingMarginConstraint = NSLayoutConstraint()
    
    private var activityIndicatorTopMarginConstraint = NSLayoutConstraint()
    private var activityIndicatorBottomMarginConstraint = NSLayoutConstraint()
    private var activityIndicatorCenterXConstraint = NSLayoutConstraint()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hideDescriptionLabel()
    }
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.heroCellBackgroundColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = Colors.marvelRed
        return ai
    }()
    
    func configure(artworkCellViewModel: HeroArtworkCellViewModel?) {
        
        self.backgroundColor = Colors.interfaceStyleHighlightColor()
        
        if let viewModel = artworkCellViewModel {
            
            removeLoadingAnimation()
            
            titleLabel.text = viewModel.heroArtwork.title
            
            if let description = viewModel.heroArtwork.description {
                if !description.isEmpty {
                    descriptionLabel.text = description
                    
                    if viewModel.shouldDisplayDescription {
                        showDescriptionLabel()
                    } else {
                        hideDescriptionLabel()
                    }
                }
            }
        } else {
            addLoadingAnimation()
        }
    }
    
    override func setupViews() {
        initializeConstraints()
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(activityIndicator)
        cellBackgroundView.addSubview(descriptionLabel)
        cellBackgroundView.addSubview(titleLabel)
        
        addConstraint(cellBackgroundViewTopMarginConstraint)
        addConstraint(cellBackgroundViewBottomMarginConstraint)
        addConstraint(cellBackgroundViewLeadingMarginConstraint)
        addConstraint(cellBackgroundViewTrailingMarginConstraint)
        
        addConstraint(titleLabelTopMarginConstraint)
        addConstraint(titleLabelBottomMarginConstraint)
        addConstraint(titleLabelLeadingMarginConstraint)
        addConstraint(titleLabelTrailingMarginConstraint)
        
        addConstraint(descriptionLabelLeadingMarginConstraint)
        addConstraint(descriptionLabelTrailingMarginConstraint)
    }
    
    private func showDescriptionLabel() {
        removeConstraint(titleLabelBottomMarginConstraint)
        self.accessoryType = .none
        descriptionLabel.isHidden = false
        addConstraint(descriptionLabelTopMarginConstraint)
        addConstraint(descriptionLabelBottomMarginConstraint)
    }
    
    private func hideDescriptionLabel() {
        self.accessoryType = .disclosureIndicator
        descriptionLabel.isHidden = true
        removeConstraint(descriptionLabelTopMarginConstraint)
        removeConstraint(descriptionLabelBottomMarginConstraint)
        addConstraint(titleLabelBottomMarginConstraint)
    }
    
    func addLoadingAnimation() {
        activityIndicator.startAnimating()
        
        addConstraint(activityIndicatorTopMarginConstraint)
        addConstraint(activityIndicatorBottomMarginConstraint)
        addConstraint(activityIndicatorCenterXConstraint)
    }
    
    func removeLoadingAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func initializeConstraints() {
        cellBackgroundViewTopMarginConstraint = NSLayoutConstraint(item: cellBackgroundView, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 3)
        cellBackgroundViewBottomMarginConstraint = NSLayoutConstraint(item: cellBackgroundView, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: -3)
        cellBackgroundViewLeadingMarginConstraint = NSLayoutConstraint(item: cellBackgroundView, attribute: .leadingMargin, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 3)
        cellBackgroundViewTrailingMarginConstraint = NSLayoutConstraint(item: cellBackgroundView, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -3)
        
        titleLabelTopMarginConstraint = NSLayoutConstraint(item: titleLabel, attribute: .topMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .topMargin, multiplier: 1, constant: 10)
        titleLabelBottomMarginConstraint = NSLayoutConstraint(item: titleLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .bottomMargin, multiplier: 1, constant: -10)
        titleLabelLeadingMarginConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .leadingMargin, multiplier: 1, constant: 10)
        titleLabelTrailingMarginConstraint = NSLayoutConstraint(item: titleLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -25)
        
        descriptionLabelTopMarginConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .topMargin, relatedBy: .equal, toItem: titleLabel, attribute: .bottomMargin, multiplier: 1, constant: 30)
        descriptionLabelBottomMarginConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .bottomMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .bottomMargin, multiplier: 1, constant: -5)
        descriptionLabelLeadingMarginConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .leadingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .leadingMargin, multiplier: 1, constant: 30)
        descriptionLabelTrailingMarginConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .trailingMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .trailingMargin, multiplier: 1, constant: -30)
        
        activityIndicatorTopMarginConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: cellBackgroundView, attribute: .centerX, multiplier: 1, constant: 0)
        activityIndicatorBottomMarginConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .topMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .topMargin, multiplier: 1, constant: 15)
        activityIndicatorCenterXConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .bottomMargin, relatedBy: .equal, toItem: cellBackgroundView, attribute: .bottomMargin, multiplier: 1, constant: -15)
    }
}
