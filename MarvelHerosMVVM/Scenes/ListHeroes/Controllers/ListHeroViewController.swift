//
//  ListHeroViewController.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 20/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import UIKit

class ListHeroViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var heroViewModel = HeroViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        loadData()
    }
    
    private func loadData() {
        heroViewModel.loadCharacters(offset: self.heroViewModel.offset) { result in
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.heroViewModel.numberOfRows(0) < self.heroViewModel.totalHero {
                self.heroViewModel.offset += 20
                self.loadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "heroDetailSegue" {
            prepareSegueForHeroDetailsViewController(segue: segue)
        }
    }
    
    private func prepareSegueForHeroDetailsViewController(segue: UIStoryboardSegue) {
        
        guard let heroDetailViewController = segue.destination as? HeroDetailViewController, let indexPath =
            self.collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        
        let hero = self.heroViewModel.heroAt(indexPath.row)
        heroDetailViewController.hero = hero
    }
}

extension ListHeroViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.heroViewModel.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
        
        let hero = heroViewModel.heroAt(indexPath.row)
        cell.configure(hero)
        
        return cell
    }
}

extension ListHeroViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:250)
    }
}

extension ListHeroViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        self.heroViewModel.searchByHeroName(name: searchText)
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.heroViewModel.searchActive = false
        self.searchBar.endEditing(true)
    }
}
