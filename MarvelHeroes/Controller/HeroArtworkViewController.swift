//
//  ComicsSection.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 29/03/2020.
//  Copyright © 2020 Pedro Eusébio. All rights reserved.
//

import Foundation
import UIKit

class HeroArtworkViewController: UITableViewController {
    
    private let cellId = "cellID"
    let hero: Hero
    var artwork: [[HeroArtwork]] = []
    let sectionTitles = ["Comics", "Events", "Stories", "Series"]
    var isLoadingData: Bool = false
    
    private let heroArtworkViewModel: HeroArtworkViewModel
    
    init (hero: Hero, nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        self.hero = hero
        heroArtworkViewModel = HeroArtworkViewModel(hero: hero)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HeroArtworkCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Colors.heroCellBackgroundColor
        tableView.sectionFooterHeight = 0
        
        isLoadingData = true
        tableView.showsVerticalScrollIndicator = false
        
        DispatchQueue.global().async { [weak self] in
            if let id = self?.hero.id {
                self?.heroArtworkViewModel.fetchHeroArtwork(heroId: "\(id)"){ artwork in
                    DispatchQueue.main.async {
                        self?.artwork = artwork
                        self?.isLoadingData = false
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoadingData {
            return 1
        } else {
            if !artwork[section].isEmpty {
                return artwork[section].count
            } else {
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        view.layer.cornerRadius = 10
        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        //label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .leadingMargin, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10))
        //view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        return view
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sectionTitles[section]
    //    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isLoadingData && artwork[indexPath.section].isEmpty {
            return 80
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HeroArtworkCell
        cell.backgroundColor = UIColor.black
        
        if isLoadingData {
            cell.configure(artworkCellViewModel: .none)
        } else {
            let artworkForSection = artwork[indexPath.section]
            
            if artworkForSection.isEmpty {
                cell.backgroundColor = Colors.interfaceStyleHighlightColor()
                cell.titleLabel.text = "No \(sectionTitles[indexPath.section]) for this hero 🔍"
                //heroArtworkViewModel.artworkCellsViewModels[indexPath.section][indexPath.row] = nil
            } else {
                
                //cell.accessoryType = .disclosureIndicator
                
                if let artworkViewModelForCell = heroArtworkViewModel.artworkCellsViewModels[indexPath.section][indexPath.row] {
                    cell.configure(artworkCellViewModel: artworkViewModelForCell)
                } else {
                    let artworkForCell = artwork[indexPath.section][indexPath.row]
                    heroArtworkViewModel.artworkCellsViewModels[indexPath.section][indexPath.row] = HeroArtworkCellViewModel(heroArtwork: artworkForCell, shouldDisplayDescription: false)
                    //safe to force unwrap because the array in the specified index has just been filled
                    cell.configure(artworkCellViewModel: heroArtworkViewModel.artworkCellsViewModels[indexPath.section][indexPath.row]!)                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoadingData {
            if let viewModel = heroArtworkViewModel.artworkCellsViewModels[indexPath.section][indexPath.row] {
                if let description = viewModel.heroArtwork.description {
                    if !description.isEmpty {
                        viewModel.shouldDisplayDescription.toggle()
                        tableView.reloadData()
                        
                        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: indexPath.section), at: .top, animated: false)
                    }
                }
            }
            tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
