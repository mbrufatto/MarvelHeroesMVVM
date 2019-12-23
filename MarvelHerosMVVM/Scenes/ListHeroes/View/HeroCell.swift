//
//  HeroCell.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 23/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    func configure(_ hero: Hero) {
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        
        let url = URL(string: hero.thumbnail.fullName)
        self.heroImage.kf.setImage(with: url)
        
        self.heroName.text = hero.name
    }
}
