//
//  ComicCell.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 27/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import UIKit

class ComicCell: UICollectionViewCell {
    
    @IBOutlet weak var comicName: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    
    func configure(_ comic: Comic) {
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        
        let url = URL(string: comic.thumbnail.fullName)
        self.comicImage.kf.setImage(with: url)
        
        self.comicName.text = comic.title
    }
}
