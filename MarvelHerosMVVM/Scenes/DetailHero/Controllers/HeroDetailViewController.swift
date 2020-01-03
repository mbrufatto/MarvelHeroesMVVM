//
//  HeroDetailViewController.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 26/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import UIKit
import Kingfisher

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var comicViewModel = ComicViewModel()
    private var heroId: Int = 0
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        setupDatas()
    }
    
    private func setupDatas() {
        
        if let hero = self.hero {
            hero.name.bind { self.heroName.text = $0 }
            hero.description.bind { self.heroDescription.text = $0 }
            hero.id.bind { self.heroId = $0 }
            
            let url = URL(string: (hero.thumbnail.fullName))
            self.heroImage.kf.setImage(with: url)
            
            self.comicViewModel.loadComics(heroId: self.heroId) { result in
                self.collectionView.reloadData()
            }
        }
    }
}


extension HeroDetailViewController: UICollectionViewDelegate {
    
}

extension HeroDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comicViewModel.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCell
        
        let comic = comicViewModel.comicAt(indexPath.row)
        cell.configure(comic)
        
        return cell
    }
}


extension HeroDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:200)
    }
}
