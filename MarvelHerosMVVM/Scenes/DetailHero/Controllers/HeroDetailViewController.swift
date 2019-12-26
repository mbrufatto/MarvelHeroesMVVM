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
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        setupDatas()
        
    }
    
    private func setupDatas() {
        self.heroName.text = hero?.name
        self.heroDescription.text = hero?.description
        
        let url = URL(string: (hero?.thumbnail.fullName)!)
        self.heroImage.kf.setImage(with: url)
    }
}


extension HeroDetailViewController: UICollectionViewDelegate {
    
}

extension HeroDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
