//
//  ViewController.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import UIKit

class HeroTableViewController: UITableViewController, HeroViewControllerDelegate  {
    
    weak var coordinator: MainCoordinator?
    
    private var cellId = "cellId"
    
    var selectedCellIndexPath: IndexPath?
    
    var viewModel: HeroListViewModel!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        tableView.isHidden = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        tableView.register(HeroCell.self, forCellReuseIdentifier: cellId)
        tableView.showsVerticalScrollIndicator = false
        
        let request = HeroListRequest.with(limit: 20)
        viewModel = HeroListViewModel(request: request, delegate: self)
        
        viewModel.fetchCharacters()
        viewModel.loadFavorites()
        
        /*Search*/
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Hero"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = selectedCellIndexPath {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func addToFavorites(id: Int) {
        viewModel.favorites.append(id)
        viewModel.saveFavorites()
    }
    
    func removeFromFavorites(id: Int) {
        if let index = viewModel.favorites.firstIndex(of: id) {
            viewModel.favorites.remove(at: index)
        }
        viewModel.saveFavorites()
    }
}

extension HeroTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            perform(#selector(search), with: searchText, afterDelay: 0.5)
        } else {
            viewModel.searchFor = .none

            viewModel.heroes = []
            viewModel.offset = 0
            viewModel.totalHeroes = 0
            if tableView.numberOfRows(inSection: 0) != 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            viewModel.fetchCharacters()
            tableView.reloadData()
        }
    }
    
    @objc func search(searchText: String){
        viewModel.searchFor = searchText
        
        viewModel.heroes = []
        viewModel.offset = 0
        viewModel.totalHeroes = 0
        if tableView.numberOfRows(inSection: 0) != 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        viewModel.fetchCharacters()
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {

            if searchText.isEmpty {
                viewModel.searchFor = .none

                viewModel.heroes = []
                viewModel.offset = 0
                viewModel.totalHeroes = 0
                if tableView.numberOfRows(inSection: 0) != 0 {
                    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                viewModel.fetchCharacters()
                tableView.reloadData()
            }
        }
    }
}

protocol HeroViewControllerDelegate {
    func addToFavorites(id: Int)
    func removeFromFavorites(id: Int)
}

extension HeroTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HeroCell
        
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none, isFavorite: false)
        } else {
            let hero = viewModel.hero(at: indexPath.row)
            let isFavorite = viewModel.isFavorite(heroId: hero.id)
            cell.configure(with: hero, isFavorite: isFavorite)
            if let thumbnailData = viewModel.heroThumbnailsData[hero.id] {
                cell.addThumbnail(thumbnailData: thumbnailData)
            } else {
                viewModel.loadHeroThumbnail(heroIndex: indexPath.row)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //UITableView.automaticDimension
        120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndexPath = indexPath
        let heroAtIndexPath = viewModel.hero(at: indexPath.row)
        let isFavorite = viewModel.isFavorite(heroId: heroAtIndexPath.id)
        let destination = HeroViewController(hero: heroAtIndexPath, delegate: self, favorite: isFavorite, nibName: nil, bundle: nil)
        destination.transitioningDelegate = self
        
        coordinator?.showHeroDetails(hero: heroAtIndexPath, delegate: self, favorite: isFavorite, nibName: nil, bundle: nil)
    }
}

extension HeroTableViewController: HeroListViewModelDelegate{
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        DispatchQueue.main.async {
            // 1
            guard let newIndexPathsToReload = newIndexPathsToReload else {
                //                self.indicatorView.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
                return
            }
            // 2
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    func onFetchFailed(with reason: String) {
        //        indicatorView.stopAnimating()
        
        //        let title = "Warning".localizedString
        //        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        //        displayAlert(with: title , message: reason, actions: [action])
    }
    
    func addThumbnailToCell(cellRowIndex: Int, thumbnailData: Data) {
        let indexPath = IndexPath(row: cellRowIndex, section: 0)

        if let cell = tableView.cellForRow(at: indexPath) as? HeroCell {
            cell.addThumbnail(thumbnailData: thumbnailData)
        }
    }
}

extension HeroTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchCharacters()
        }
    }
}

private extension HeroTableViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        print(indexPaths)
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension HeroTableViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        return PushHeroViewAnimation(originFrame: tableView.cellForRow(at: selectedCellIndexPath!)!.frame)
  }
}
